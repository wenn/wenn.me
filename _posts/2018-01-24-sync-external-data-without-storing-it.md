---
title: Syncing external data without storing it.
updated: 2018-01-24
---

## I would like to
I'm retrieving financial data from a bank on a user's behalf,
and layering my own data on top of the bank data. Storing the bank's 
data might conflict with the bank's policy or the willingness of the user.
Also, providing that the vendor data does not have a unqiue id.

However, I would still like to be able to store my data 
and have a reference back to the bank data for next time
the user logs back in. For example:


Bank data:
```conf
transactions:
  - date = 2018-01-23 15:10
    merchant = McDs
    amount = $5
  - date = 2018-01-24 05:30
    merchant = Target
    amount = $500
```

My data:
```conf
transactions[0]
  category = food
transactions[1]
  category = splurge
```

Essentially avoiding data being store like this:
```conf
transactions:
  - date = 2018-01-23 15:10
    merchant = McDs
    amount = $5
    category = food
  - date = 2018-01-24 05:30
    merchant = Target
    amount = $500
    category = splurge
```

## A way

Between the call to the vendor and persisting to a datastore,
we need to link the vendor's data with our data. A way to
do this is by using a hash function.

Let's assume that these already exists
```python
def get_vendor_data()
def read_from_datastore(id)
def write_to_datastore(id, my_data)
def add_more_data(vendor_trasaction)
```

Linking the data
```python
def get_data(vendor_transaction):
  _hash = hash(vendor_transaction)
  data = read_from_datastore(_hash)
  all_data = None

  if (data is None):
    all_data = add_more_data(vendor_transaction, my_data)
    write_to_datastore(_hash)
  
  return (_hash, all_data)
```

Where the hashed id is unique enough as a link to the vendor's data,
in this way, our data at rest now looks like so,
```conf
transactions:
  - id: <hash code>
    category = food
  - id: <hash code>
    category = splurge
```