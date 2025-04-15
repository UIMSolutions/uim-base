/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur)                                                  *
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file.         *
* Authors: Ozan Nurettin Süel (aka UIManufaktur)                                                                *
*****************************************************************************************************************/
module uim.phobos.datetime.timestamp;

import uim.phobos;
@safe:

enum startUNIX = DateTime(1970, 1, 1, 0, 0, 0);

long toTimestamp(SysTime untilTime) {
  return (untilTime - cast(SysTime) startUNIX).total!"hnsecs"();
}

// Convert a timestamp in string format (long value) to SysTime
SysTime fromTimestamp(string aTimestamp) {
  return fromTimestamp(to!long(aTimestamp));
}

// Convert a timestamp (long value) to SysTime
SysTime fromTimestamp(long aTimestamp) {
  return (cast(SysTime) startUNIX + aTimestamp.hnsecs);
}

long toJSTimestamp(long jsTimestamp) {
  return (fromJSTimestamp(jsTimestamp) - cast(SysTime) startUNIX).total!"msecs"();
}

SysTime fromJSTimestamp(long jsTimestamp) {
  return (cast(SysTime) startUNIX + jsTimestamp.msecs);
}

// Current SysTime based on System Clock
auto now() {
  return Clock.currTime();
}

unittest {
  auto now1 = now;
  auto now2 = now;
  assert(now2 >= now1);
}
