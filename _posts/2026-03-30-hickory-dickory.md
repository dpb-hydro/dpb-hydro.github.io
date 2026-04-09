---
layout: single
title: "Hickory Dickory Dock"
date: 2026-03-30 15:05:00 +0100
last_modified_at: 2026-04-09 11:00:00 +0100
categories: reflections
tags: dynamics epistemology
header:
  teaser: /assets/images/hare_tortoise.jpg
related: true
---

*The philosophy of the cranes, presses, and pumps is finished and clear like a circle. But is your philosophy less circular? The beauty of a mechanism lies in its immutable, precise rhythm, like that of a pendulum. But have you not become as precise as a pendulum, you who are brought up on the system of Taylor? Yes, but there is one difference: MECHANISMS HAVE NO FANCY. Did you ever notice a pump cylinder during its work show upon its face a wide, distant, sensuously-dreaming smile? Did you ever hear cranes restlessly toss about and sigh at night, during the hours designed for rest? NO!*   
|| Yevgeny Zamyatin, *We*

{% include figure image_path="/assets/images/hare_tortoise.jpg" alt="The hare and tortoise clock, Rugby, UK" caption="The hare and tortoise clock, Rugby, UK" %}

One of my maths teachers at secondary school had a great saying: *when it's tricky, draw a piccy*. I've found this philosophy enormously helpful throughout my studies, not least during my recent revisit to the study of differential equations through this [excellent course](https://www.coursera.org/learn/differential-equations-engineers?specialization=mathematics-engineers).

Differential equations are a quintessential subject across all branches of engineering. For me, the most vivid example is the undergraduate course in structural dynamics that I took. As fundamental as the subject is, I'll confess my intuition for it has always been a little shaky (pun intended). But when differential equations describe systems we encounter every day, that needn't be the case. What has genuinely helped me is making animations of the physical systems themselves, rather than simply plotting phase diagrams of response variables. The difference, I think, is that experiencing time as a spatial dimension is deeply counterintuitive, whereas when it unfolds as we actually experience it, even complex behaviour becomes much more legible. It's no coincidence that chaos theory emerged so late; we simply lacked the computational tools to visualise it.

Recently I've been getting to grips with the Julia ecosystem, and have put together `Springies.jl`, a wrapper around [OrdinaryDiffEq.jl](https://docs.sciml.ai/OrdinaryDiffEq/stable/) for exploring dynamical systems visually. There's no better way to build intuition than to play. When I did work experience at a mechanical engineering firm, I was envious of how tactile the work was; engineers could pick up, modify, and test the things they were designing. That kind of hands-on tinkering is harder to come by in civil engineering. In the world of computational modelling, a sandbox for playing with systems of ODEs goes some way towards filling that gap. Below are some of the animations I've made with this tool, which I wanted to share here because, above all else, they're a lot of fun!

## Pendulums

The equation for a forced pendulum looks scary:


$$m l \ddot{\theta} + c l \dot{\theta} + m g \sin\theta = F,$$

but it's just describing a sum of forces. In this form, the equation is simply saying

$$\text{Internal forces} = \text{External force}.$$

Conceptually, what do the internal forces represent?

- $$m l \ddot{\theta}$$: inertia, because the pendulum has mass and is accelerating,
- $$c l \dot{\theta}$$: the effect of resistances,
- $$m g \sin\theta$$: the restoring force pulling the weight back towards the centre.

The external force, $$F$$, is simply an arbitrary applied force. We can set it to whatever we like, depending on how we want to drive the pendulum.

### Unforced pendulums

What if we set the external forcing to zero? Then only the internal forces act on the pendulum. To set it in motion, we can either drop it from rest:

{% include figure image_path="/assets/images/unforced_pendulum_dropped.gif" alt="An unforced pendulum dropped from rest" caption="An unforced pendulum dropped from rest" %}

or launch it with a nonzero initial velocity:

{% include figure image_path="/assets/images/unforced_pendulum_launched.gif" alt="An unforced pendulum launched with an initial velocity" caption="An unforced pendulum launched with an initial velocity" %}

Either way, the resulting motion is a familiar one: the pendulum swings back and forth, with an amplitude that gradually decreases over time. Seeing the scary pendulum equation brought to life in this way really cuts it down to size.

### Forced pendulums

So what about clocks? A clock pendulum runs for a long time without any decrease in amplitude. What's going on here? The effect of damping is overcome by giving the pendulum small pushes. We can make a crude simulation of this by applying the forcing whenever the pendulum is swinging outwards. A real clock mechanism is more sophisticated than this, but the principle is clear:

{% include figure image_path="/assets/images/clock_pendulum.gif" alt="A crude clock pendulum" caption="A crude clock pendulum" %}

This clock pendulum would need a bit of tuning to count in seconds!

When we learn about pendulums at school, the go-to example is often a child being pushed on a playground swing. While this does illustrate the concept, I found the analogy got in the way when it came to thinking about buildings shaking in earthquakes. Once again I must invoke [this point](https://youtube.com/clip/Ugkx0h_TQUrvBg3TiopIKHIlLCO1biL5VXn6?si=IkY3h2mcP-XfosF4) by Prof Eric Laithwaite. In the swing example, the pusher can **only** push at the natural frequency of the child, but in other systems, the force can be applied at any time. When an earthquake shakes a building, the ground doesn't need to wait for the building to complete a full oscillation before delivering another push.

`Springies.jl` lets us visualise this more cleanly than a physical model would. The natural instinct for a physical experiment might be to shake the entire pendulum setup, but this makes it conceptually difficult to separate the forcing from the response. Instead, we can simply simulate an arbitrary external force acting directly on the pendulum weight:

{% include figure image_path="/assets/images/forced_pendulum.gif" alt="A continuously forced pendulum" caption="A continuously forced pendulum" %}

After some initial complicated behaviour, the pendulum settles into a steady pattern that matches the forcing frequency. There is some maths behind why this happens, but the animation alone makes the phenomenon considerably more intuitive.

## The Double Gyre

One of my original motivations for developing `Springies.jl` was to revisit the canonical [Double Gyre](https://shaddenlab.berkeley.edu/uploads/LCS-tutorial/overview.html) problem; the toy problem on which I first cut my teeth in dynamical systems. I'll resist the temptation to wax lyrical about it as its beauty speaks for itself:

{% include figure image_path="/assets/images/double_gyre.gif" alt="The mesmerising Double Gyre" caption="The mesmerising Double Gyre" %}

Early in my MPhil, this was a useful playground for thinking about how quantities are transported by moving fluids. The image it always conjures for me is the little tornado of leaves and Freddo wrappers that used to swirl in front of the newsagent near my school, caused by the way the surrounding walls channelled the wind. In this example, each particle moves at exactly the velocity prescribed by the flow field at its current time and location. Beautiful as it is, the analogy breaks down when we consider real objects such as Freddo wrappers, which are subject to additional influences such as their own inertia. What happens when we introduce something a little more substantial?

Looking out of the window recently, I was inspired by the waves rippling through grass as the wind moved over it. What would happen if we planted grass under the Double Gyre? Modelling the grass blades as flexible columns, and decoupling the $$x$$ and $$y$$ components so that each blade behaves as two independent springs, this is what I got:

{% include figure image_path="/assets/images/grassy_gyre.gif" alt="The grassy Double Gyre" caption="The grassy Double Gyre" %}

I haven't thought carefully about the physical relevance of this yet, but it looks pretty! Note that although the motion may appear collective, the restoring force on each particle depends only on its own initial position, not on its neighbours. A natural extension might be to introduce inter-particle restoring forces; the *Jelly Gyre*, perhaps?

## The Three-Body Problem

Another classic of dynamical systems is the three-body problem, which has perplexed some of the greatest mathematical minds in history:

{% include figure image_path="/assets/images/three_body_short.gif" alt="The Three-body Problem" caption="The Three-body Problem" %}

I won't attempt to say anything profound here — this is purely for aesthetic enjoyment, much like a lava lamp. The one concession I will make is to run the simulation for longer, to see whether a bound pair eventually forms with the third body being ejected:

{% include figure image_path="/assets/images/three_body_long.gif" alt="Long-time simulation of the Three-body Problem" caption="Long-time simulation of the Three-body Problem" %}

*Why is the dance beautiful? Answer: because it is **nonfree** movement, because all of the fundamental significance of the dance lies precisely in its aesthetic subjection, its ideal nonfreedom.*   
|| Yevgeny Zamyatin, *We*
