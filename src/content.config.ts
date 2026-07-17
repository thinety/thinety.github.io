import type { Loader } from "astro/loaders";
import { defineCollection } from "astro:content";
import { z } from "astro/zod";

import RssParser from "rss-parser";

function rssFeedLoader(feedUrls: string[]) {
  return {
    name: "rss-feed-loader",
    load: async ({ store, logger, parseData }) => {
      const fetchFeed = async (feedUrl: string) => {
        try {
          const response = await fetch(feedUrl, {
            signal: AbortSignal.timeout(10000),
          });
          const xml = await response.text();
          const parser = new RssParser();
          const feed = await parser.parseString(xml);

          return {
            posts: feed.items
              .map((item) => {
                if (item.title === undefined) return undefined;
                if (item.link === undefined) return undefined;
                if (item.isoDate === undefined) return undefined;

                const title = item.title.trim();

                let postUrl = URL.parse(item.link);
                if (postUrl == null) {
                  // remove host if present
                  const i = item.link.indexOf("/");
                  if (i > 0) {
                    item.link = item.link.slice(i);
                  }
                  // try to parse as relative reference
                  postUrl = new URL(item.link, feedUrl);
                }
                postUrl.protocol = "https:";
                postUrl.search = "";
                const link = postUrl.toString();

                const date = new Date(item.isoDate);

                return {
                  title,
                  link,
                  date,
                };
              })
              .filter((post) => post !== undefined),
          };
        } catch (error) {
          logger.warn(`Fetching feed failed: ${feedUrl}\n${error}`);
        }
        return store.get(feedUrl)?.data;
      };

      const feeds = await Promise.all(
        feedUrls.map(async (feedUrl) => [feedUrl, await fetchFeed(feedUrl)] as const),
      );

      store.clear();
      for (const [feedUrl, feed] of feeds) {
        if (feed === undefined) {
          logger.warn(`Feed could not be obtained: ${feedUrl}`);
          continue;
        }
        try {
          const data = await parseData({
            id: feedUrl,
            data: feed,
          });
          store.set({
            id: feedUrl,
            data,
          });
        } catch (error) {
          logger.warn(`Parsing feed failed: ${feedUrl}\n${error}`);
        }
      }
    },
    schema: z.object({
      posts: z.array(
        z.object({
          title: z.string(),
          link: z.string(),
          date: z.date(),
        }),
      ),
    }),
  } satisfies Loader;
}

const feeds = defineCollection({
  loader: rssFeedLoader([
    "https://ahal.ca/blog/index.xml",
    "https://andrewkelley.me/rss.xml",
    "https://bal-e.org/blog/rss.xml",
    "https://becca.ooo/atom.xml",
    "https://bitbashing.io/feed.xml",
    "https://blog.ihatereality.space/atom.xml",
    "https://blog.janestreet.com/feed.xml",
    "https://blog.m-ou.se/index.xml",
    "https://blog.pnkfx.org/atom.xml",
    "https://blog.sheerluck.dev/rss.xml",
    "https://borretti.me/feed.xml",
    "https://bower.sh/rss",
    "https://burntsushi.net/index.xml",
    "https://byorgey.github.io/blog/rss.xml",
    "https://calabro.io/atom",
    "https://donsz.nl/rss.xml",
    "https://echasnovski.com/blog.xml",
    "https://elijahpotter.dev/rss.xml",
    "https://fasterthanli.me/index.xml",
    "https://faultlore.com/blah/rss.xml",
    "https://filipesilva.github.io/paulgraham-rss/feed.rss",
    "https://fitzgen.com/feed.xml",
    "https://geeklaunch.io/blog/index.xml",
    "https://glfmn.io/atom.xml",
    "https://goldstein.lol/index.atom",
    "https://graydon2.dreamwidth.org/data/atom",
    "https://harudagondi.space/rss.xml",
    "https://home.expurple.me/posts/index.xml",
    "https://hugotunius.se/feed.xml",
    "https://jacobasper.com/blog/atom.xml",
    "https://jade.fyi/rss.xml",
    "https://jonathan-frere.com/index.xml",
    "https://jvns.ca/atom.xml",
    "https://jyn.dev/atom.xml",
    "https://kristoff.it/index.xml",
    "https://kyju.org/blog/atom.xml",
    "https://lexi-lambda.github.io/feeds/all.atom.xml",
    "https://limpet.net/mbrubeck/atom.xml",
    "https://lottia.net/notes/atom.xml",
    "https://lyra.horse/blog/posts/index.xml",
    "https://manishearth.github.io/atom.xml",
    "https://matklad.github.io/feed.xml",
    "https://mcyoung.xyz/feed.xml",
    "https://mitchellh.com/feed.xml",
    "https://mmapped.blog/feed.xml",
    "https://mrcjkb.dev/atom.xml",
    "https://nadrieril.github.io/blog/feed.xml",
    "https://neugierig.org/software/blog/atom.xml",
    "https://nnethercote.github.io/feed.xml",
    "https://purplesyringa.moe/blog/feed.rss",
    "https://research.swtch.com/feed.atom",
    "https://ryhl.io/rss.xml",
    "https://sabrinajewson.org/blog/feed.xml",
    "https://smallcultfollowing.com/babysteps/atom.xml",
    "https://sot.dev/feed.xml",
    "https://strongly-typed-thoughts.net/blog/feed",
    "https://tanyaverma.sh/feed.xml",
    "https://thesquareplanet.com/feed.xml",
    "https://tigerbeetle.com/blog/atom.xml",
    "https://tmandry.gitlab.io/blog/index.xml",
    "https://transactional.blog/feed.xml",
    "https://trifectatech.org/atom-feed.xml",
    "https://typesanitizer.com/blog/rss.xml",
    "https://typst.app/blog/atom.xml",
    "https://without.boats/index.xml",
    "https://www.awwsmm.com/rss.xml",
    "https://www.boxyuwu.blog/index.xml",
    "https://www.judy.co.uk/atom.xml",
    "https://www.ralfj.de/blog/feed.xml",
    "https://www.scattered-thoughts.net/atom.xml",
    "https://www.vectorware.com/blog/rss.xml",
    "https://yosefk.com/blog/feed",
    "https://ziglang.org/devlog/index.xml",
    "https://zignar.net/index.xml",
  ]),
});

export const collections = { feeds };
