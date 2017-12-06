#lang pollen
    Title: Grammar Zela Halalelu (Day 2)
    Date: 2017-12-06T23:23:00
    Tags: English, Language, Anime, Made in Abyss

Today I watched the episodes where Hanezeve Caradhina was played (1, 8, 9), and further confirmed myself that it indeed feels like describing Riko's journey.

With that, I got a rough idea for the first line that's along the lines with `I'm dreaming a dream`.

## Dreaming the grammar

I started with how "halalaha" and "halalelu" both have the common prefix "hala-". Since I was already thinking about using "dream" as the idea of the line, I defined "hala-" to be a prefix related to thoughts, and "-laha" to be "fiction", "illusion".

- "hala-": word decorator (sort of an adjective), says that the word is thoughts-related
- "-laha": noun, "fiction", "illusion"

Matching up with my rough idea for the first line, I defined "halalelu" to be the verb "dream", and zela to be "I". This creates a syntax for a sentence: "Hala-laha zela hala-lelu" ⇒ "Imagination I Dream". It is a "Object Subject Verb" sentence structure.

## Today's progress

The first paragraph is now:

> I am dreaming a dream<br>
> to explore even deeper<br>
> the treasure, the wonder<br>
> deep in the Abyss<br>

And I now have a rough grammar:

```
Sentence := Object Subject Action
Object := noun-phrase
Subject := noun-phrase
Action := verb-phrase
"Halalaha zela halalelu"

noun-phrase := (noun [preposition-phrase])
"Hanezeve cara-dhina" "Hanezeve" "houwelela" "lalelila"

verb-phrase := (verb [decorator-phrase])
"Sivivile shi-dhina"

preposition-phrase := (preposition [decorator-phrase])
"cara-dhina"

decorator-phrase := ([decorator] decorator)
"shi-dhina"
```
