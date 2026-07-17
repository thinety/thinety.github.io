import { defineConfig, fontProviders } from "astro/config";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  // instead of adding `"types": ["node"]` to `tsconfig.json`, which would
  // (wrongly) make types for node globals available everywhere in the project,
  // we ignore this single usage of the `process` global, because we know
  // this file is executed by Astro in a node process.
  // @ts-expect-error
  site: process.env.ASTRO_SITE,
  trailingSlash: "always", // match GitHub Pages setting
  fonts: [
    {
      provider: fontProviders.google(),
      name: "Montserrat",
      cssVariable: "--font-montserrat",
    },
  ],
  vite: {
    plugins: [tailwindcss()],
  },
});
