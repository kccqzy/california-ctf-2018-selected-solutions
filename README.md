# California CTF 2018 Selected Solutions

This repository contains source code and walkthroughs of several problems used
in the California CTF 2018, which took place across three college campuses on
April 28, 2018. It took place at UCLA between 1:30 and 7:30 at Carnesale
Palisades.

This is a beginner-oriented CTF, which means it contains a wide range of
different difficulty levels. Some are very easy (most teams are able to solve
it); others are very hard (only one or two teams could solve it). Some
problems are fairly commonplace, and similar problems are employed at other
beginner CTFs; others could be quite unique.

Note that only selected problems have their solutions published! This is so
that we may reuse some problems for the future.

## Technical Details

For web problems (those involving the organizing setting up a server in
advance), [Docker](https://www.docker.com) is used to simplify deployment and
reproducibility. To run these problems on your own computer, you must have
Docker installed. A few of the problems also use [Docker
Compose](https://docs.docker.com/compose/overview/) which is a simple way of
configuring multiple related containers.

Please note, however, that the Dockerfiles used to build these containers
could involve specific URLs and specific tags on Docker Hub; we therefore
cannot guarantee that years from today, these containers can still be built.

For non web problems, we generally use a simpler build procedure. Sometimes we
provide simple Makefiles.

## Archived!

This repo is archived and read-only. Please do not submit issues or PRs. Even if
there might be issues, we don't want to fix it because we want to preserve the
original state of the problem as it happened during the CTF. Feel free to fork
it however; we have a liberal license!
