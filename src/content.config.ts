import { defineCollection } from "astro:content";
import { z } from "astro/zod";

import RssParser from "rss-parser";

const blogroll = defineCollection({
  loader: async () => {
    const feedUrls = [
      "https://andrewkelley.me/rss.xml",
      "https://bitbashing.io/feed.xml",
      "https://fasterthanli.me/index.xml",
      "https://kristoff.it/index.xml",
      "https://matklad.github.io/feed.xml",
      "https://nadrieril.github.io/blog/feed.xml",
      "https://smallcultfollowing.com/babysteps/atom.xml",
      "https://without.boats/index.xml",
    ];

    const fetchFeed = async (url: string) => {
      let feed;
      try {
        const response = await fetch(url);
        const xml = await response.text();
        const parser = new RssParser();
        feed = await parser.parseString(xml);
      } catch (error) {
        console.error(error);
        return [];
      }

      return feed.items
        .map((item) => {
          const url = new URL(item.link!);
          url.search = "";
          const link = url.toString();

          const date = new Date(item.isoDate!);

          return {
            ...item,
            id: link,
            link,
            date,
          };
        })
        .sort((a, b) => b.date.getTime() - a.date.getTime())
        .slice(0, 5);
    };

    return (await Promise.all(feedUrls.map(fetchFeed)))
      .flat()
      .sort((a, b) => b.date.getTime() - a.date.getTime());
  },
  schema: z.object({
    title: z.string(),
    link: z.string(),
    date: z.date(),
  }),
});

export const collections = { blogroll };
