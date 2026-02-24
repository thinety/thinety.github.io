import { defineCollection } from "astro:content";
import { z } from "astro/zod";

import RssParser from "rss-parser";

const blogroll = defineCollection({
  loader: async () => {
    const feedUrls = [
      "https://ahal.ca/blog/index.xml",
      "https://andrewkelley.me/rss.xml",
      "https://becca.ooo/atom.xml",
      "https://bitbashing.io/feed.xml",
      "https://blog.m-ou.se/index.xml",
      "https://blog.v-gar.de/feed/",
      "https://boehs.org/in/blog.xml",
      "https://bower.sh/rss",
      "https://burntsushi.net/index.xml",
      "https://buttondown.com/hillelwayne/rss",
      "https://byorgey.github.io/blog/rss.xml",
      "https://fasterthanli.me/index.xml",
      "https://faultlore.com/blah/rss.xml",
      "https://filipesilva.github.io/paulgraham-rss/feed.rss",
      "https://glfmn.io/atom.xml",
      "https://gynvael.coldwind.pl/rss_en.php",
      "https://jade.fyi/rss.xml",
      "https://jonathan-frere.com/index.xml",
      "https://jvns.ca/atom.xml",
      "https://jyn.dev/atom.xml",
      "https://kristoff.it/index.xml",
      "https://lottia.net/notes/atom.xml",
      "https://lyra.horse/blog/posts/index.xml",
      "https://manybutfinite.com/feed.xml",
      "https://matklad.github.io/feed.xml",
      "https://mcyoung.xyz/feed.xml",
      "https://mitchellh.com/feed.xml",
      "https://mmapped.blog/feed.xml",
      "https://mrcjkb.dev/atom.xml",
      "https://nadrieril.github.io/blog/feed.xml",
      "https://neugierig.org/software/blog/atom.xml",
      "https://offby1.website/feeds/all.atom.xml",
      "https://research.swtch.com/feed.atom",
      "https://smallcultfollowing.com/babysteps/atom.xml",
      "https://strongly-typed-thoughts.net/blog/feed",
      "https://tigerbeetle.com/blog/atom.xml",
      "https://transactional.blog/feed.xml",
      "https://typesanitizer.com/blog/rss.xml",
      "https://without.boats/index.xml",
      "https://www.judy.co.uk/atom.xml",
      "https://www.ralfj.de/blog/feed.xml",
      "https://www.scattered-thoughts.net/atom.xml",
      "https://www.teamten.com/lawrence/writings/rss.xml",
      "https://yosefk.com/blog/feed",
      "https://ziglang.org/devlog/index.xml",
      "https://zignar.net/index.xml",
    ];

    const fetchFeed = async (feedUrl: string) => {
      // biome-ignore lint/suspicious/noImplicitAnyLet: false positive
      let feed;
      try {
        const response = await fetch(feedUrl);
        const xml = await response.text();
        const parser = new RssParser();
        feed = await parser.parseString(xml);
      } catch (error) {
        console.error(error);
        return [];
      }

      return feed.items.flatMap((item) => {
        if (item.link === undefined) return [];

        // biome-ignore lint/suspicious/noImplicitAnyLet: false positive
        let postUrl;
        if (item.link.startsWith("/")) {
          postUrl = new URL(item.link, feedUrl);
        } else if (!item.link.startsWith("https")) {
          postUrl = new URL(`https://${item.link}`);
        } else {
          postUrl = new URL(item.link);
        }
        postUrl.search = "";

        const link = postUrl.toString();

        if (item.isoDate === undefined) return [];
        const date = new Date(item.isoDate);

        return {
          ...item,
          id: link,
          link,
          date,
        };
      });
    };

    const selectedPosts = [];

    const feeds = await Promise.all(feedUrls.map(fetchFeed));

    // keep the most recent post from each feed
    for (const feed of feeds) {
      feed.sort((a, b) => a.date.getTime() - b.date.getTime());
      const post = feed.pop();
      if (post === undefined) continue;
      selectedPosts.push(post);
    }

    const posts = feeds
      .flat()
      .sort((a, b) => a.date.getTime() - b.date.getTime());

    // select remaining posts until a maximum
    while (selectedPosts.length < 100) {
      const post = posts.pop();
      if (post === undefined) break;
      selectedPosts.push(post);
    }

    return selectedPosts.sort((a, b) => b.date.getTime() - a.date.getTime());
  },
  schema: z.object({
    title: z.string(),
    link: z.string(),
    date: z.date(),
  }),
});

export const collections = { blogroll };
