---
title: JS again - 1, dynamic sorting with objects.
updated: 2018-01-23
---

{% include series/js.again.md %}

Relearning **Javascript** part one. 
How to sort a list of objects dynamically?

# Some data
```javascript
const births = [
  {
    name: "Paul Rudd",
    birth: new Date("1969/04/06")
  },
  {
    name: "Edward Norton",
    birth: new Date("1969/08/18")
  },
  {
    name: "Keanu Reeves",
    birth: new Date("1964/09/02")
  }
]
```

# Sorting fn
```javascript
function by(key) {
  return (a, b) => (a[key] >= b[key] ? 1 : -1);
}
```

```javascript
> births.sort(by("birth"))
[ 
  { name: 'Keanu Reeves', birth: 1964-09-02T05:00:00.000Z },
  { name: 'Paul Rudd', birth: 1969-04-06T05:00:00.000Z },
  { name: 'Edward Norton', birth: 1969-08-18T05:00:00.000Z } 
]
```

```javascript
> births.sort(by("name"))
[ 
  { name: 'Edward Norton', birth: 1969-08-18T05:00:00.000Z },
  { name: 'Keanu Reeves', birth: 1964-09-02T05:00:00.000Z },
  { name: 'Paul Rudd', birth: 1969-04-06T05:00:00.000Z }
]
```

# Adding descending/ascending
```javascript
function by(key) {
  const isDesc = /^-/.test(key);
  const cleanKey = key.replace(/^[-+]/, "")

  return (a, b) =>
    isDesc
      ? (a[cleanKey] <= b[cleanKey] ? 1 : -1)
      : (a[cleanKey] >= b[cleanKey] ? 1 : -1);
}
```

```javascript
> births.sort(by("-name"))
[ 
  { name: 'Paul Rudd', birth: 1969-04-06T05:00:00.000Z },
  { name: 'Keanu Reeves', birth: 1964-09-02T05:00:00.000Z },
  { name: 'Edward Norton', birth: 1969-08-18T05:00:00.000Z }
]
```

```javascript
> births.sort(by("+name"))
[ 
  { name: 'Edward Norton', birth: 1969-08-18T05:00:00.000Z },
  { name: 'Keanu Reeves', birth: 1964-09-02T05:00:00.000Z },
  { name: 'Paul Rudd', birth: 1969-04-06T05:00:00.000Z }
]
```

