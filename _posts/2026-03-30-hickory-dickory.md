---
layout: single
title: "Hickory Dickory Dock"
date: 2026-03-30 15:05:00 +0100
last_modified_at: 2026-03-30 15:05:00 +0100
categories: reflections
tags: dynamics epistemology
header:
  teaser: /assets/images/hare_tortoise.jpg
related: true
---

*The philosophy of the cranes, presses, and pumps is finished and clear like a circle. But is your philosophy less circular? The beauty of a mechanism lies in its immutable, precise rhythm, like that of a pendulum. But have you not become as precise as a pendulum, you who are brought up on the system of Taylor? Yes, but there is one difference: MECHANISMS HAVE NO FANCY. Did you ever notice a pump cylinder during its work show upon its face a wide, distant, sensuously-dreaming smile? Did you ever hear cranes restlessly toss about and sigh at night, during the hours designed for rest? NO!*   
|| Yevgeny Zamyatin, *We*

{% include figure image_path="/assets/images/hare_tortoise.jpg" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

One of my maths teachers at secondary school had a great saying: *when it's tricky, draw a piccy*. I've found this philosophy extremely helpful during my studies, not least with my recent revisit to this excellent course on [differential equations](https://www.coursera.org/learn/differential-equations-engineers?specialization=mathematics-engineers). This is a quintessential subject in all branches of engineering; in my case the most prominent example that comes to mind is the undergraduate course in the dynamics of structures which I sat. As important as the subject is I must confess my intuition for differential equations has always been shaky (pun intended). But when they describe systems which we look at every day, this oughtn't be the case. What has really helped me has been making animations of the systems themselves rather than just plotting phase diagrams of response variables. I think the difference is that experiencing time as a spatial dimension is counterintuitive, whereas when we experience it as we as humans experience time then these complex representations collapse to something much more intuitive. This is why chaos was discovered so late; simply because we couldn't visualise these things easily.

Recently I have been getting to grips with the Julia computing ecosystem, and have developed a wrapper for [OrdinaryDiffEq.jl](https://docs.sciml.ai/OrdinaryDiffEq/stable/) for playing with dynamical syatems toys. Ultimately playing is the best way to make discoveries. When I did work experience at a mechanical ewngineering company I was jealous that they were able to fidde around with the components that they designeds, whereas this is less simple to do in civil engineering! But in my line of work which is now modelling, a sandbox such as this is really useful. Below I wanted to share some of my animations because above all else, they are really fun!

## Unforced pendulums

We can launch a pendulum by dropping it from rest:

{% include figure image_path="/assets/images/unforced_pendulum_dropped.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

And we can also launch it with a nonzero initial velocity:

{% include figure image_path="/assets/images/unforced_pendulum_launched.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

## Forced pendulums

If we apply a periodic forcing to the pendulum, it eventually reaches a steady state controlled by that forcing. This steady state can be found through nondimensionalisation:

{% include figure image_path="/assets/images/forced_pendulum.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

We can also do a basic simulation of a clock:

{% include figure image_path="/assets/images/clock_pendulum.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

## The Double Gyre

We can use `Springies.jl` to play with advection in the canonical Double Gyre problem:

{% include figure image_path="/assets/images/double_gyre.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

What if, instead of a velocity field, we were to think of the Double Gyre over a field of grass? Let's model the grass blades as flexible beams; we'll decouple the x and y components so that we can think of two springs, one in the x and the other in the y direction:

{% include figure image_path="/assets/images/grassy_gyre.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

## The Three-body problem

Here is an example of the three-body problem in 2D:

{% include figure image_path="/assets/images/three_body_short.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

If we run the simulation for longer, we can see the formation of a bound pair and the ejection of the third body. This is sometimes called the "Heggie-Hills law" (or the statistical escape hypothesis):

{% include figure image_path="/assets/images/three_body_long.gif" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

*Why is the dance beautiful? Answer: because it is **nonfree** movement, because all of the fundamental significance of the dance lies precisely in its aesthetic subjection, its ideal nonfreedom.*   
|| Yevgeny Zamyatin, *We*