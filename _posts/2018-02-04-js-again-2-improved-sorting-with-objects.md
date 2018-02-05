---
title: JS again - 2, improved sorting with objects.
updated: 2018-02-04
---

Relearning **Javascript** part two. 

In the last [JS again part one](/notes/js-again-1-dynamic-sorting-with-objects), we sorted 
objects by one attribute. However, using only one attribute does not have
a deterministic behavior. Subsequent sorts could produce different
ordering of objects when other attributes of the object are tied.


# Revisting the sort function.
This is our sort function from the JSA - 1. 
We'll be using this sort function for this example as well.
Let's clean it up a bit more before moving forward.

From this:
```javascript
function by(key) {
  const isDesc = /^-/.test(key)
  const cleanKey = key.replace(/^[-+]/, "")

  return (a, b) =>
    isDesc
      ? (a[cleanKey] <= b[cleanKey] ? 1 : -1)
      : (a[cleanKey] >= b[cleanKey] ? 1 : -1);
}
```

To this:
```javascript
function by(key) {
  const toggle = /^-/.test(key) ? -1 : 1;
  const cleanKey = key.replace(/^[-+]/, "")

  return (a, b) => {
    if (a[cleanKey] < b[cleanKey]) return toggle;
    if (a[cleanKey] > b[cleanKey]) return -1 * toggle;

    return 0;
  }
}
```

This functionality is similar, but we are now 
correctly considering cases for ties: `return 0`.


# Now for the data, Ghibli movies.
```javascript
[
  {name: "Howl's Moving Castle", rating: 5},
  {name: "Spirited Away", rating: 5},
  {name: "Porco Rosso", rating: 5},
  {name: "Princess Mononoke", rating: 5},
  {name: "The Wind Rises", rating: 5},
  {name: "Kiki's Delivery Service", rating: 5},
  {name: "Tales from Earthsea", rating: 2}
]
```

When we sort the movies by ratings, there will be 6 ties
excluding *Tales from Earthsea*. 
The objects will be ordered by the **ratings**, 
but not by the **name** of the movies; each rating of **5** 
will return **0** when compared with other **5**s.

# Making it deterministic.
To make sorting of the Ghibli movies deterministic 
we need to sort the movies' names as well. Something like this:

```javascript
function by(key) {
  const toggle = /^-/.test(key) ? -1 : 1;
  const cleanKey = key.replace(/^[-+]/, "")

  return (a, b) => {
    if (a[cleanKey] < b[cleanKey]) return toggle;
    if (a[cleanKey] > b[cleanKey]) return -1 * toggle;
    if (a.name < b.name) return 1;
    if (a.name > b.name) return -1;

    return 0;
  }
}
```

It works, but our abstraction is lost, since now 
it knows about the Ghibli movies data structure.

Also, what happens when there are objects with 3, 4 or 5+ attributes,
would we then would need to add `if` statements for each attributes?

Maybe, if we really want to full control of the ordering,
but for this example we want to keep the abstraction for the sort `by`.

# Keeping it abstract.
To ensure the sort is deterministic, 
we still need to sort on a secondary field, and one that
is unique enough to break ties effectively like a unique `id` of
the object.

Since `id` is not provided for our movies, we can 
create one using a hash function. To keep it simple, pretend 
that we already have a `sha1(str) => str` function defined.

Now, give each of our movies an `id`.

```javascript
const gm = gibliMovies
  .slice()
  .map( m => {
    const newM = Object.assign({}, m);
    newM.uuid = sha1(newM.name + newM.rating);

    return newM;
  });
```

And modify our sort `by` function to be aware of an `id`.

```javascript
function by(key) {
  const toggle = /^-/.test(key) ? -1 : 1;
  const cleanKey = key.replace(/^[-+]/, "")

  return (a, b) => {
    if (a[cleanKey] < b[cleanKey]) return toggle;
    if (a[cleanKey] > b[cleanKey]) return -1 * toggle;
    if (a.id < b.id) return 1;
    if (a.id > b.id) return -1;

    return 0;
  }
}
```

Sort it.
```javascript
  gm.sort(by("rating"));
```

Our primary sort be rating.
When it ties, 
the sort will fallback to the `id` of objects,
which should give us the same result for each subsequent sort.