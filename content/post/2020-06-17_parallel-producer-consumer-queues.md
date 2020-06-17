---
# Documentation: https://sourcethemes.com/academic/docs/managing-content/

title: "Parallel Producer Consumer Queues"
subtitle: "In java and C#"
summary: "Many programs do some sort of data transform and can be described as
read/generate some data, process the data, write the output. It's always beneficial
if some steps are performed in parallel. E.g. the reader pre-fetches a few data items
so that when the 'processing' part of the program is ready for a new chunk of data
the data is already there waiting. Ths post provides two quick solutions for java and
C#. Java with Project Reactor. C# using TPL Dataflow (Task Parallel Library)."
authors: []
tags: [java, csharp, queue, pipeline, reactive]
categories: [java, csharp]
date: 2020-06-17T10:17:37-07:00
lastmod: 2020-06-17T10:17:37-07:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

## Preamble
Many programs do some sort of data transform and can be described as
read/generate some data, process the data, write the output. It's always beneficial
if some steps are performed in parallel. E.g. the reader pre-fetches a few data items
so that when the 'processing' part of the program is ready for a new chunk of data
the data is already there waiting. Ths post provides two quick solutions for java and
C#. Java with [Project Reactor](https://projectreactor.io/). C# using [TPL Dataflow](https://docs.microsoft.com/en-us/dotnet/standard/parallel-programming/dataflow-task-parallel-library)
(Task Parallel Library).

# C# TPL Dataflow
The example code produces (reads etc.) new items concurrently with processing said items, maintaining a read-ahead buffer. The completion signal is sent to the head of the chain when the "producer" has no more items. The program also awaits the completion of the whole chain before terminating.  
Posted in [this StackOverflow thread](https://stackoverflow.com/questions/61951466/backpressure-via-bufferblock-not-working-c-tpl-dataflow/62012626#62012626) on the topic.

```csharp
static async Task Main() {

    string Time() => $"{DateTime.Now:hh:mm:ss.fff}";

    // the buffer is added to the chain just for demonstration purposes
    // the chain would work fine using just the built-in input buffer
    // of the `action` block.
    var buffer = new BufferBlock<int>(new DataflowBlockOptions {BoundedCapacity = 3});

    var action = new ActionBlock<int>(async i =>
    {
        Console.WriteLine($"[{Time()}]: Processing: {i}");
        await Task.Delay(500);
    }, new ExecutionDataflowBlockOptions {MaxDegreeOfParallelism = 2, BoundedCapacity = 2});

    // it's necessary to set `PropagateCompletion` property
    buffer.LinkTo(action, new DataflowLinkOptions {PropagateCompletion = true});

    //Producer
    foreach (var i in Enumerable.Range(0, 10))
    {
        Console.WriteLine($"[{Time()}]: Ready to send: {i}");
        await buffer.SendAsync(i);
        Console.WriteLine($"[{Time()}]: Sent: {i}");
    }

    // we call `.Complete()` on the head of the chain and it's propagated forward
    buffer.Complete(); 

    await action.Completion;
}
```

# Java, Project Reactor
Reactive processing: async IO producer with prefetch and in-order consumers (Project Reactor 3.x).
Posted to [this StackOverflow thread](https://stackoverflow.com/questions/61885623/reactive-processing-async-io-producer-with-prefetch-and-in-order-consumers-mwe/61930266#61930266).  

### Problem statement:
Do I/O in chunks. Start processing chunks as soon as one becomes available, while further chunks are being read in background (but not more than *X* chunks are read ahead). Process chunks in parallel as they are being received. Consume each processed chunk in-order-of-reading, i.e. in original order of the chunk being read.

### Pseudo-Rx code explanation of what we'd like to achieve:

```java
Flux.fromFile(path, some-function-to-define-chunk)
   // done with Flux.generate in MWE below

 .prefetchOnIoThread(x-count: int)
   // at this point we try to maintain a buffer filled with x-count pre-read chunks

 .parallelMapOrdered(n-threads: int, limit-process-ahead: int)
   // n-threads: are constantly trying to drain the x-count buffer, doing some transformation
   // limit-process-ahead: as the operation results are needed in order, if we encounter an
   // input element that takes a while to process, we don't want the pipeline to run too far
   // ahead of this problematic element (to not overflow the buffers and use too much memory)

 .consume(TMapped v)
```

### My solution

```java
final int threads = 2;
final int prefetch = 3;

Flux<Integer> gen = Flux.generate(AtomicInteger::new, (ai, sink) -> {
  int i = ai.incrementAndGet();
  if (i > 10) {
    sink.complete();
  } else {
    sink.next(i);
  }
  return ai;
});

gen.parallel(threads, prefetch)             // switch to parallel processing after genrator
    .runOn(Schedulers.parallel(), prefetch) // if you don't do this, it won't run in parallel
    .map(i -> i + 1000)                     // this is done in parallel
    .ordered(Integer::compareTo)            // you can do just .sequential(), which is faster
    .subscribeOn(Schedulers.elastic())      // generator will run on this scheduler (once subscribed)
    .subscribe(i -> {
      System.out.printf("Transformed integer: " + i); // do something with generated and processed item
    });
```
