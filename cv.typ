#let name = "Thiago Trannin"
#let accent-color = rgb("#26428b")
#let spacing = 0.8cm


#set document(author: name, title: name)

#set page(margin: spacing)

#set text(
  lang: "en",
  font: "New Computer Modern",
  size: 10pt,
  // Disable ligatures so ATS systems do not get confused when parsing fonts.
  ligatures: false,
)

#set par(justify: true)


#show link: underline
#show link: set text(fill: accent-color)

#show heading: set text(fill: accent-color)

#show heading.where(level: 1): set text(weight: 700, size: 2.5em)

#show heading.where(level: 2): it => {
  pad(top: 0em, bottom: -1em, smallcaps(it.body))
  line(length: 100%, stroke: 1pt)
}


#grid(
  columns: (1fr, auto),
  gutter: spacing,
  [
    #[
      #set align(center)

      = #name

      #let my-link(protocol, destination, body: none) = link(
        protocol + destination,
        if body != none { body } else { destination },
      )
      #(
        box("+55 41 99145 1155"),
        box("Ingolstadt, Bayern, Germany"),
        my-link("mailto:", "t.j.t.trannin@gmail.com"),
        my-link("https://", "github.com/thinety"),
        my-link("https://", "thinety.github.io/about", body: "thinety.github.io"),
        my-link("https://", "linkedin.com/in/tranninthiago"),
      ).join(" | ")
    ]

    == Summary

    Software engineer pursuing a Master's double degree in Electrical and Automotive
    Engineering, and fascinated by how computers work. As a former competitive
    programming competitor, I'm very competent when it comes to algorithms, data
    structures and Computer Science fundamentals. Lately, I've been passionate about
    systems programming, networking, and low level software in general --- I'd be
    very happy to work in a team of talented individuals whose interests line up with mine.

    // I'm a strong advocate of Rust and believe that it is a great technology in the
    // systems programming domain because it allows one to write software that's not
    // only fast but also safe and correct.

    // Some open-source contributions of mine involving Rust, although they are either purely documentation, or very modest code changes:
    // - https://github.com/rust-lang/rust/pull/94522
    // - https://github.com/rust-lang/rust/pull/100893
    // - https://github.com/typst/typst/pull/810
    // - https://github.com/rust-lang/nomicon/pull/456
    // - https://github.com/poem-web/poem/pull/848
    // - https://github.com/nats-io/nats.rs/pull/1365
    // - https://github.com/nats-io/nats.rs/pull/1366
  ],
  box(clip: true, radius: 50%, image("public/me.jpg", width: 18em)),
)


== Skills

#strong[Programming languages]: C, C++, Rust, Zig, Python, JavaScript, TypeScript, Haskell, VHDL \
#strong[Frontend]: React, React Native, Tailwind, Astro \
#strong[Backend]: Node.js, Flask, Axum \
#strong[Databases]: PostgreSQL, SQLite \
#strong[Data processing]: NumPy, Pandas, OpenCV, PyTorch \
#strong[Environment tools]: Linux, Docker, Git, Bash, ROS \
#strong[Languages]: Portuguese (native), English (fluent), German (intermediate)

== Experience

#[
  #let job(
    titles: "",
    dates: "",
    company: "",
    location: "",
  ) = [
    #for (title, date) in titles.zip(dates) [
      #strong(title) #h(1fr) #strong(date) \
    ]
    #company #h(1fr) #location \
  ]

  #job(
    titles: (
      [Student Assistant],
    ),
    dates: (
      [May 2025 --- March 2026],
    ),
    company: [Technische Hochschule Ingolstadt],
    location: [Ingolstadt, Germany],
  )
  - Extended the V2X open-source simulation framework Artery to support
    transmission of VAMs (VRU Awareness Messages) by bicyclists.

  #job(
    titles: (
      [Backend Engineer Intern],
    ),
    dates: (
      [November 2024 --- December 2024],
    ),
    company: [C Channel],
    location: [Tokyo, Japan],
  )
  - Assessed the impact in customer conversions of using event data from
    the company's in-house e-storefront platform.
    Implemented integrations with the Conversion APIs from Meta and TikTok.
  - This position was sponsored by the Japanese government by means of a
    coding contest which involved students from countries in Africa and Latin
    America. The best candidates were invited for a month-long internship at
    a Japanese company.

  #job(
    titles: (
      [Software Developer I],
      [Software Developer Intern],
    ),
    dates: (
      [June 2024 --- February 2025],
      [July 2023 --- May 2024],
    ),
    company: [Pumatronix],
    location: [Curitiba, Brazil],
  )
  - Developed embedded software that runs in traffic control cameras.
  - Worked on very diverse tasks in firmware development and systems
    programming: from optimization of image processing routines and design
    of data processing pipelines to parsers, logging systems, FFI,
    network protocols, CPU and memory profiling, web interfaces, and automated testing.
  - Refactored a monolithic C++ project in smaller, independent modules.
    Pioneered Rust adoption in safety-critical functionality and maintained
    its integration with existing code via the C ABI.

  #job(
    titles: (
      [Machine Learning Engineer Intern],
    ),
    dates: (
      [January 2023],
    ),
    company: [DeepX],
    location: [Tokyo, Japan],
  )
  - Designed a keypoint detection model for estimation of the position in 3D space
    of an excavator machine's arm; the model's input was the video feed from a camera
    above the operator's seat.
  - This position was sponsored by the Japanese government by means of a
    coding contest which involved students from countries in Africa and Latin
    America. The best candidates were invited for a month-long internship at
    a Japanese company.

  #job(
    titles: (
      [Development Analyst],
      [Software Developer Intern],
    ),
    dates: (
      [May 2022 --- December 2022],
      [July 2021 --- April 2022],
    ),
    company: [Fiscaltech Tecnologia e Automação],
    location: [Curitiba, Brazil],
  )
  - Applied classic computer vision algorithms to detect vehicles stopped over
    crosswalks.
  - Researched and developed deep learning models for smart traffic monitoring
    applications, such as vehicle classification, vehicle tracking and license
    plate reading via optical character recognition.
  - Deployed cross-compiled native libraries that abstracted over the
    aforementioned problems, with accompanying wrappers for high-level languages.
]

== Education

#[
  #let edu(
    institution: "",
    location: "",
    degree: "",
    dates: "",
  ) = [
    #strong(institution) #h(1fr) #strong(location) \
    #degree #h(1fr) #dates
  ]

  #edu(
    institution: [Technische Hochschule Ingolstadt (THI)],
    location: [Ingolstadt, Germany],
    degree: [Master's degree in Automotive Engineering],
    dates: [March 2025 --- Present],
  )

  #edu(
    institution: [Federal University of Paraná (UFPR)],
    location: [Curitiba, Brazil],
    degree: [Master's degree in Electrical Engineering],
    dates: [July 2024 --- Present],
  )

  #edu(
    institution: [Federal University of Paraná (UFPR)],
    location: [Curitiba, Brazil],
    degree: [Bachelor's degree in Electrical Engineering],
    dates: [January 2019 --- June 2024],
  )
  - Emphasis on Electronics and Telecommunications
  - Thesis title: "Artificial noise applied to PLC systems under threat of WLC eavesdropper"
  // Studied the effect of a carefully generated kind of noise in the physical layer security
  // of a power line communication system
]

== Awards

#strong[2024 -- International Collegiate Programming Contest (ICPC) South America / Brazil Finals -- Highest Honor] \
23rd place out of 65 teams

#strong[2024 -- Professor Plínio Alves Monteiro Tourinho Award -- Gold medal] \
Top of the class in Electrical Engineering: academic performance index 0.9858/1.0

#strong[2018 -- Brazilian Public School Mathematics Olympiad (OBMEP) -- Bronze medal] \
Level 3 -- private school
