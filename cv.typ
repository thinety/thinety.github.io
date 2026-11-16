#let name = "Thiago Trannin"
#let accent-color = rgb("#26428b")
#let spacing = 0.70cm


#set document(author: name, title: name)

#set page(margin: spacing)

#set text(
  lang: "en",
  font: "New Computer Modern",
  size: 9pt,
  // Disable ligatures so ATS systems do not get confused when parsing fonts.
  ligatures: false,
)

#set par(justify: true)


#show link: underline
#show link: set text(fill: accent-color)

#show heading: set text(fill: accent-color)

#show heading.where(level: 1): set text(weight: 700, size: 2.0em)

#show heading.where(level: 2): it => {
  pad(top: 0em, bottom: -1em, smallcaps(it.body))
  line(length: 100%, stroke: 1pt)
}


#let header = {
  set align(center)

  heading(name)

  let my-link(protocol, destination, body: none) = link(
    protocol + destination,
    if body != none { body } else { destination },
  )

  (
    box("Munich, Germany"),
    box("+49 175 3819985"),
    box(my-link("mailto:", "t.j.t.trannin@gmail.com")),
    box(my-link("https://", "thinety.github.io/about", body: "thinety.github.io")),
    box(my-link("https://", "github.com/thinety")),
    // box(my-link("https://", "tangled.org/thinety.eurosky.social")),
    box(my-link("https://", "linkedin.com/in/tranninthiago")),
    // box(my-link("https://", "sifa.id/p/thinety.eurosky.social")),
  ).join(h(1fr) + "|" + h(1fr))
}

#let summary = [
  == Summary

  Software Engineer and double-degree Master's student in Electrical and Automotive
  Engineering, interested in systems programming, operating systems, networking,
  and low-level software in general. Strong foundation in algorithms and data structures
  through competitive programming.

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
]

#let picture = box(clip: true, radius: 50%, image("src/assets/me.jpg", width: 20em))

#let skills = [
  == Skills

  #strong[Programming Languages]: C, C++, Rust, Zig, Python, JavaScript, TypeScript, Lua, Haskell, OCaml, Bash, VHDL \
  #strong[Frontend Development]: React, React Native, Tailwind CSS, Astro, HTML5, CSS3 \
  #strong[Backend Development & Distributed Systems]: Node.js, Express, Flask, Axum, REST APIs, HTTP, WebSockets, gRPC, Protobuf \
  #strong[Databases]: SQL, PostgreSQL, SQLite, DuckDB, Redis \
  #strong[Data Science & Machine Learning]: NumPy, Pandas, OpenCV, PyTorch, large language models (LLMs), AI agents \
  #strong[Systems Programming & Embedded Systems]: Linux, Yocto, CMake, GDB, Valgrind, sanitizers, Tokio, concurrency, multithreading \
  #strong[Cloud Computing & DevOps]: AWS, Docker, Podman, Kubernetes, CI/CD, GitHub Actions \
  #strong[Development Tools & Methodologies]: Git, Shell, Neovim, test-driven development (TDD), Agile, Scrum, Kanban, Jira, Confluence \
  #strong[Spoken Languages]: Portuguese (native), English (fluent), German (intermediate), French (beginner)
]

#let experience = [
  == Experience

  #let job(
    titles: "",
    dates: "",
    company: "",
    location: "",
  ) = {
    for (title, date) in titles.zip(dates) {
      strong(title)
      h(1fr)
      strong(date)
      linebreak()
    }
    company
    h(1fr)
    location
  }

  #job(
    titles: (
      [Working Student Rust Engineering],
    ),
    dates: (
      [May 2026 --- October 2026],
    ),
    company: [BMW Group],
    location: [Munich, Germany],
  )
  // - Assessed and optimized the performance of microservices running in cloud
  //   environments, mostly written in Rust using the Tokio asynchronous runtime.
  // - Developed and maintained internal developer tools to facilitate access
  //   to databases hosted on Amazon RDS.
  // - Ported custom big data workflows to Apache Spark and deployed them on
  //   Amazon EMR Serverless.
  // - Improved the performance of Java services, particularly the deserialization
  //   of custom formats into in-memory data structures.
  // - Interacted on a daily basis with AWS services such as S3, Lambda and EKS.
  // - Became familiar with the use of agentic AI to accelerate development of
  //   Rust software.
  - Optimized production Java microservices using async-profiler and flamegraphs,
    refining custom-format deserialization until JVM operations, rather than
    application code, became the primary performance bottleneck.
  - Profiled production Rust microservices using perf and flamegraphs, analyzing
    Tokio task execution and blocking operations to identify performance
    bottlenecks and optimize latency and cloud resource utilization.
  - Developed a Rust CLI/TUI for accessing Amazon RDS databases, automating
    authentication, AWS profile discovery, database enumeration, and Kubernetes
    jump-pod provisioning within the databases' VPCs; leveraged AI-assisted
    code generation to accelerate development.

  // #job(
  //   titles: (
  //     [Student Assistant],
  //   ),
  //   dates: (
  //     [May 2025 --- March 2026],
  //   ),
  //   company: [Technische Hochschule Ingolstadt],
  //   location: [Ingolstadt, Germany],
  // )
  // - Extended the V2X open-source simulation framework Artery to support
  //   transmission of VAMs (VRU Awareness Messages) by bicyclists.

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
  - Assessed the impact of event data from the company's e-storefront platform
    in customer conversions through Meta's and TikTok's APIs.
  - Position sponsored by the Japanese government through a coding contest involving
    students from countries in Africa and Latin America.

  #job(
    titles: (
      // [Software Developer I],
      // [Software Developer Intern],
      [Software Developer],
    ),
    dates: (
      // [June 2024 --- February 2025],
      // [July 2023 --- May 2024],
      [July 2023 --- February 2025],
    ),
    company: [Pumatronix],
    location: [Curitiba, Brazil],
  )
  // - Developed embedded software that runs in traffic control cameras.
  // - Worked on diverse tasks in firmware and systems
  //   programming: from optimization of image processing routines and design
  //   of data processing pipelines to parsers, logging systems, FFI,
  //   network protocols, CPU and memory profiling, web interfaces, and automated testing.
  // - Refactored a monolithic C++ project in smaller, independent modules.
  //   Pioneered Rust adoption in safety-critical functionality and maintained
  //   its integration with existing code via the C ABI. Integrated the Tokio
  //   runtime into existing asynchronous C++ code.
  - Developed and maintained embedded software for traffic-control cameras,
    spanning image-processing routines, data pipelines, parsers, logging systems,
    FFI, network protocols, CPU and memory profiling, web interfaces, and automated testing.
  - Modularized a monolithic C++ codebase and introduced Rust through the C ABI,
    replacing a crash-prone module with a memory-safe implementation that exposed
    image-data to external REST clients. Integrated Tokio into existing asynchronous C++ code.
  - Improved image-processing performance by copying DMA-backed sensor buffers
    into process-owned RAM early, increasing memory locality and cache utilization.

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
  - Designed a keypoint detection model for pose estimation of an excavator machine's
    arm using camera feed from above the operator's seat.
  - Position sponsored by the Japanese government through a coding contest involving
    students from countries in Africa and Latin America.

  #job(
    titles: (
      // [Development Analyst],
      // [Software Developer Intern],
      [Development Analyst],
    ),
    dates: (
      // [May 2022 --- December 2022],
      // [July 2021 --- April 2022],
      [July 2021 --- December 2022],
    ),
    company: [Fiscaltech Tecnologia e Automação],
    location: [Curitiba, Brazil],
  )
  // - Applied classic computer vision algorithms to detect vehicles stopped over
  //   crosswalks.
  // - Researched and developed deep learning models for smart traffic monitoring
  //   applications, such as vehicle classification, vehicle tracking and license
  //   plate reading via optical character recognition.
  // - Deployed cross-compiled native libraries for computer vision tasks,
  //   with accompanying wrappers for high-level languages.
  - Developed traditional computer-vision and deep-learning solutions for traffic
    monitoring, including crosswalk violation detection, vehicle classification
    and tracking, and license-plate recognition (OCR).
  - Owned the end-to-end development and deployment of C++ computer-vision
    libraries, from implementation to Linux-to-Windows cross-compilation and
    Python/Java wrappers, abstracting complex vision functionality behind
    high-level APIs for consumption by other teams.
]

#let education = [
  == Education

  #let edu(
    institution: "",
    location: "",
    degree: "",
    dates: "",
  ) = {
    strong(institution)
    h(1fr)
    strong(location)
    linebreak()

    degree
    h(1fr)
    dates
  }

  #edu(
    institution: [Technische Hochschule Ingolstadt (THI)],
    location: [Ingolstadt, Germany],
    degree: [Master's degree in Automotive Engineering],
    dates: [March 2025 --- March 2027 (expected)],
  )

  #edu(
    institution: [Federal University of Paraná (UFPR)],
    location: [Curitiba, Brazil],
    degree: [Master's degree in Electrical Engineering],
    dates: [July 2024 --- January 2027 (expected)],
  )

  #edu(
    institution: [Federal University of Paraná (UFPR)],
    location: [Curitiba, Brazil],
    degree: [Bachelor's degree in Electrical Engineering (emphasis in Electronics and Telecommunications)],
    dates: [January 2019 --- June 2024],
  )
  // - Thesis title: "Artificial noise applied to PLC systems under threat of WLC eavesdropper"
  // Studied the effect of a carefully generated kind of noise in the physical layer security
  // of a power line communication system
]

#let awards = [
  == Awards

  #strong[2024 -- International Collegiate Programming Contest (ICPC) South America / Brazil Finals -- Highest Honor] \
  23rd place out of 65 teams

  #strong[2024 -- Professor Plínio Alves Monteiro Tourinho Award -- Gold medal] \
  Top of the class in Electrical Engineering: academic performance index 0.9858/1.0

  // #strong[2018 -- Brazilian Public School Mathematics Olympiad (OBMEP) -- Bronze medal] \
  // Level 3 -- private school
]

// #grid(
//   columns: (1fr, auto),
//   gutter: spacing,
//   [
#header
#summary
//   ],
//   picture,
// )

#skills
#experience
#education
#awards
