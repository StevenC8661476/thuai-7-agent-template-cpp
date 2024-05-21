# syntax=docker/dockerfile:1

FROM gcc:12.3.0 AS build-env
WORKDIR /app
RUN curl -fsSL https://xmake.io/shget.text | bash
COPY xmake.lua .
RUN ~/.local/bin/xmake f -m release -v -y --root
COPY . .
RUN ~/.local/bin/xmake -v --root

FROM gcr.nju.edu.cn/distroless/cc-debian12
WORKDIR /app
COPY --from=build-env /app/bin/agent .
ENTRYPOINT ["./agent"]
