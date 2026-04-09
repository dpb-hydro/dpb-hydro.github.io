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

One of my maths teachers at secondary school had a great saying: *when it's tricky, draw a piccy*. I've found this philosophy enormously helpful throughout my studies, not least during my recent revisit to the study of differential equations through this [excellent course](https://www.coursera.org/learn/differential-equations-engineers?specialization=mathematics-engineers).

Differential equations are a quintessential subject across all branches of engineering. For me, the most vivid example is the undergraduate course in structural dynamics that I took. As fundamental as the subject is, I'll confess my intuition for it has always been a little shaky (pun intended). But when differential equations describe systems we encounter every day, that needn't be the case. What has genuinely helped me is making animations of the physical systems themselves, rather than simply plotting phase diagrams of response variables. The difference, I think, is that experiencing time as a spatial dimension is deeply counterintuitive, whereas when it unfolds as we actually experience it, even complex behaviour becomes much more legible. It's no coincidence that chaos theory emerged so late; we simply lacked the computational tools to visualise it.

Recently I've been getting to grips with the Julia ecosystem, and have put together `Springies.jl`, a wrapper around [OrdinaryDiffEq.jl](https://docs.sciml.ai/OrdinaryDiffEq/stable/) for exploring dynamical systems visually. There's no better way to build intuition than to play. When I did work experience at a mechanical engineering firm, I was envious of how tactile the work was; engineers could pick up, modify, and test the things they were designing. That kind of hands-on tinkering is harder to come by in civil engineering. In the world of computational modelling, a sandbox for playing with systems of ODEs goes some way towards filling that gap. Below are some of the animations I've made with this tool, which I wanted to share here because, above all else, they're a lot of fun!

## Pendulums

The equation for a periodically forced pendulum looks scary:

$$m l \ddot{\theta} + c l \dot{\theta} + m g \sin\theta = F,$$

but it's just describing sums of forces. In this form, the equation is simply saying

$$\text{Internal forces} = \text{External force}.$$

Conceptually, what do the internal forces mean?

- $m l \ddot{\theta}$: inertia, because the pendulum is heavy and moving,
- $c l \dot{\theta}$: the effect of resistances,
- $m g \sin\theta$: the string pulling the weight back to the centre.

The external force, $F$, is just an arbitrary applied force. We could set this to anything we want, depending on how we want to push the pendulum.

### Unforced pendulums 

What if we just set the external forcing to zero? Then the only forces acting on the pendulum are the internal ones. To set the pendulum moving, we can either drop it from rest:

{% include figure image_path="/assets/images/unforced_pendulum_dropped.gif" alt="An unforced pendulum dropped from rest" caption="An unforced pendulum dropped from rest" %}

or we can instead launch it with a nonzero initial velocity:

{% include figure image_path="/assets/images/unforced_pendulum_launched.gif" alt="An unforced pendulum launched from rest" caption="An unforced pendulum launched from rest" %}

Either way, the resulting motion is a familiar one. The pendulum swings back and forth, first with a large amplitude, which gradually decreases with time. Seeing the scary equation $m l \ddot{\theta} + c l \dot{\theta} + m g \sin\theta = 0$ in this way really cuts it down to size.

### Forced pendulums

So what about clocks? They have pendulums which run for a long time without decreasing in amplitude. What's going on here? The effect of damping is overcome by giving the pendulum little pushes. We can make a crude simulation of this by setting our forcing $F$ to act when the pendulum is swinging outwards. A real clock is a bit more complicated than this, but we can see the idea:

{% include figure image_path="/assets/images/clock_pendulum.gif" alt="A crude clock pendulum" caption="A crude clock pendulum" %}

This clock pendulum would need a bit of tuning to count in seconds!

When we learn about pendulums at school, an example that is often given is that of a child being pushed on a playground swing. While this does explain the concept, when it came to thinking about buildings shaking in earthquakes at university, I found the analogy to get in the way of my understanding a little bit. Once again I must invoke [this point](https://youtube.com/clip/Ugkx0h_TQUrvBg3TiopIKHIlLCO1biL5VXn6?si=IkY3h2mcP-XfosF4) by Prof Eric Laithwaite. In the swing example, the pusher can **only** push at the natural frequency of the child on the swing, but in other systems, the force can be applied at any time. In the case of the ground shaking a building, the ground doesn't need to wait for the building to do a full back and forth motion before giving it a different kind of push.

I think that `Springies.jl` can help us to visualise this situation a little easier than a physical model would in this case. If we were to model this using a physical setup, the first intuition would be to shake the pendulum setup to apply a continuous forcing to the pendulum. But this makes it hard to conceptulaly disentangle what's going on. Rather than using a reversing magnetic field to force the pendulum, we can just simulate an arbitrary force which acts externally on the pendulum weight:

{% include figure image_path="/assets/images/forced_pendulum.gif" alt="A continuously forced pendulum" caption="A continuously forced pendulum" %}

In this animation, we can see that after some initial complicated behaviour, the pendulum settles down to a pattern which matches the forcing. There is some maths we can do to show why this happens, but the point is that seeing this animation, at least to me, makes it a great deal clearer what's actually going on when we're talking about forced pendulums.

## The Double Gyre

One of my original inspirations to develop `Springies.jl` was to revisit the canonical [Double Gyre](https://shaddenlab.berkeley.edu/uploads/LCS-tutorial/overview.html) problem. I must resist the temptation to wax lyrical about this, as this was the toy problem on which I first cut my teeth in dynamical systems:

{% include figure image_path="/assets/images/double_gyre.gif" alt="The mesmerising Double Gyre" caption="The mesmerising Double Gyre" %}

Early in my MPhil days, this was a useful playground for thinking about things carried by moving fluids. The image that is always invoked in my mind is the little tornado of leaves and Freddo wrappers that used to blow around in front of the newsagents near my school on account of how the walls were. In this example, the particles move at exactly the velocity presrvibed by the field at that time and location. While beautiful, the comparison breaks down when we consider real objects, which are subject to other influences, such as their mass. What if we wanted to consider a more weighty example?

Looking out of the window recently I was inspired by the waves I could see in the grass as the wind progressively blew over it. What would happen if we planted grass in the Double Gyre? Let's model the grass blades as flexible columns; we'll decouple the x and y components so that we can think of two springs, one in the x and the other in the y direction:

{% include figure image_path="/assets/images/grassy_gyre.gif" alt="The grassy gyre" caption="The grassy gyre" %}

To be honest I haven't really considered the usefulness of this yet, but it looks cool! Note that although it looks like the force on the particles depends on the surrounding particles, the restoring force in this case depends on the starting position of the particle, not on the surrounding particles. Perhaps an idea for a new simulation could be where the restoring force depends on the surrounding particles; the Jelly Gyre?

## The Three-body problem

Another classic dynamical systems toy is the Three-body problem, which has challenged some of the greatest mathematical minds of history:

{% include figure image_path="/assets/images/three_body_short.gif" alt="The Three-body Problem" caption="The Three-body Problem" %}

In my case I don't want to be challenged, this is purely here for aesthetic purposes. It's kind of like looking at a lava lamp! The one effort that I will make on this example is running the simulation for a little longer to see if we can see the formation of a bound pair and the ejection of the third body

{% include figure image_path="/assets/images/three_body_long.gif" alt="Long-time simulation of the Three-body Problem" caption="Long-time simulation of the Three-body Problem" %}

*Why is the dance beautiful? Answer: because it is **nonfree** movement, because all of the fundamental significance of the dance lies precisely in its aesthetic subjection, its ideal nonfreedom.*   
|| Yevgeny Zamyatin, *We*