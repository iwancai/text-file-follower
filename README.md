

# TODO

- Handle all exceptions. For example, in the `onchange` handler, if the file 
  disappears between the `fs.statSync` check and the `fs.createReadStream` call 
  (or between when watchit emits `'change'` and the `fs.statSync` call), an 
  `ENOENT` exception will occur. This will probably bring down the process.
  - If we assume that watchit's `retain` works, then the correct behaviour is 
    probably to just quietly swallow the error and return. Operations will 
    continue when the file is re-created. 

- Move .coffee to /src and add make target that compiles to /lib. 

- Add test case(s) for a followed file that gets deleted and re-created.
  - Guaranteed to fail on Linux at this time due to a 
    [watchit bug](https://github.com/TrevorBurnham/Watchit/issues/1).

- Add 'catchup' (process whole file first) feature.

- Run through linter.

- Properly handle pre-existing partial line when watcher first starts
  - Or state explicitly that it won't be handled.

- Make a behaviour rule for if the file shrinks
  - Don't start returning lines until it reaches the previous maximum length?
  - Start returning lines when the file starts growing again? (Prolly that.)

- Make encoding an option?

# Observations

Note: All while using `{retain:true}`.

## Windows

- After a rename or unlink (both of which trigger an `'unlink'` event), the 
  following change triggers `'create'` and `'success'` events, but not a `'change'`. 
  So another change it required before the first change will be read.

## Linux

- Due to a [watchit bug](https://github.com/TrevorBurnham/Watchit/issues/1) 
  (which itself is due to a `fs.watch` oddity), when a watched file is deleted 
  (or renamed) and recreated, the result will be two watchers.
