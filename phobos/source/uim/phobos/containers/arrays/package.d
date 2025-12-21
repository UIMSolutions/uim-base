/****************************************************************************************************************
* Copyright: © 2018-2025 Ozan Nurettin Süel (aka UIManufaktur) 
* License: Subject to the terms of the Apache 2.0 license, as written in the included LICENSE.txt file. 
* Authors: Ozan Nurettin Süel (aka UIManufaktur)
*****************************************************************************************************************/
module uim.phobos.containers.arrays;

public {
  import uim.phobos.containers.arrays.array_;
  import uim.phobos.containers.arrays.chunks;
  import uim.phobos.containers.arrays.compact;
  import uim.phobos.containers.arrays.concat;
  import uim.phobos.containers.arrays.contains;
  import uim.phobos.containers.arrays.cross;
  import uim.phobos.containers.arrays.deduplicate;
  import uim.phobos.containers.arrays.differences;
  import uim.phobos.containers.arrays.distribute;
  import uim.phobos.containers.arrays.drop;
  import uim.phobos.containers.arrays.duplicates;
  import uim.phobos.containers.arrays.every;
  import uim.phobos.containers.arrays.filtermap;
  import uim.phobos.containers.arrays.find;
  import uim.phobos.containers.arrays.first;
  import uim.phobos.containers.arrays.flattenmap;
  import uim.phobos.containers.arrays.fold;
  import uim.phobos.containers.arrays.foldright;
  import uim.phobos.containers.arrays.has;
  import uim.phobos.containers.arrays.get;
  import uim.phobos.containers.arrays.group;
  import uim.phobos.containers.arrays.indexof;
  import uim.phobos.containers.arrays.insert;
  import uim.phobos.containers.arrays.intersect;
  import uim.phobos.containers.arrays.last;
  import uim.phobos.containers.arrays.merge;
  import uim.phobos.containers.arrays.minmax;
  import uim.phobos.containers.arrays.move;
  import uim.phobos.containers.arrays.nat;// ive;
  import uim.phobos.containers.arrays.partition;
  import uim.phobos.containers.arrays.pick;
  import uim.phobos.containers.arrays.positions;
  import uim.phobos.containers.arrays.remove;
  import uim.phobos.containers.arrays.replace;
  import uim.phobos.containers.arrays.reverse;
  import uim.phobos.containers.arrays.rotate;
  import uim.phobos.containers.arrays.sample;
  import uim.phobos.containers.arrays.shuffle;
  import uim.phobos.containers.arrays.sorting;
  import uim.phobos.containers.arrays.split;
  /* import uim.phobos.containers.arrays.splice;
  import uim.phobos.containers.arrays.sum;
  import uim.phobos.containers.arrays.swap;
  import uim.phobos.containers.arrays.take;
  import uim.phobos.containers.arrays.transpose;
  import uim.phobos.containers.arrays.transform;
  import uim.phobos.containers.arrays.unique;
  import uim.phobos.containers.arrays.unzipmap;
  import uim.phobos.containers.arrays.zipmap;
  import uim.phobos.containers.arrays.zipwith;
  import uim.phobos.containers.arrays.zipwithindex;
  import uim.phobos.containers.arrays.zipwithindexes;
  import uim.phobos.containers.arrays.zipwithmap; */ 

  import uim.phobos.containers.arrays.isempty;
  import uim.phobos.containers.arrays.filter;
  import uim.phobos.containers.arrays.flatten;
  import uim.phobos.containers.arrays.pairs;
  import uim.phobos.containers.arrays.rest;
  import uim.phobos.containers.arrays.shift;
  import uim.phobos.containers.arrays.string_;
  import uim.phobos.containers.arrays.without;
  import uim.phobos.containers.arrays.unzip;
  import uim.phobos.containers.arrays.zip;
}
