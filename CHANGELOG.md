## 4.0.0 (unreleased)
### Added
- `untracevar` command that stops tracing a global variable.
- Window CI build through AppVeyor.
- OSX CI build through Travis.
- Style enforcement through RuboCop.
- C style enforment using the `indent` command line utility.
- Some remote debugging tests (thanks @eric-hu).
- Printer's support (thanks @astashov).

### Changed
- A lot of internal refactoring.
- `tracevar` now requires the full global variable name (with "$").
- `catch` command is not allowed in post_mortem mode anymore. It was not
working anyways (#92).

### Fixed
- Code reloading issues.
- `set fullpath` was not showing fullpaths. Now it is.
- `up`, `down` and `frame` commands now work in post_mortem mode (#93).
- Loading of .byebugrc. Now it ignores invalid commands instead of aborting.
- Priority of .byebugrc files. Project's file overrides global (home) file.
- Backtraces not working in `post_mortem` mode (#93).
- 'cmd1 ; cmd2 ; ...; cmdN' syntax which allows running several commands
sequentially.

### Removed
- `autoreload` setting as it's not necessary anymore. Code should always be up
to date.
- `reload` command for the same reason.
- Gem dependency on `debugger-linecache`.
- `step+`, `step-`, `next+`, `next-`, `set/show linetrace_plus` and
`set/show forcestep` commands. These were all mechanisms to deal with TracePoint
API event dupplication, but this duplicated events have been completely removed
from the API since
[r48609](bugs.ruby-lang.org/projects/ruby-trunk/repository/revisions/48609), so
they are no longer necessary.

## 3.5.1 - 2014-09-29
### Fixed
- Windows installation (#79).
- `condition` command not properly detecting invalid breakpoint ids.

## 3.5.0 - 2014-09-28
### Fixed
- Byebug's history messing other programs using Readline (#81).
- Readline's history not being properly saved and inmediately available.
- User not being notified when trying to debug a non existent script.

### Changed
- Complete rewrite of byebug's history.
- Complete rewrite of list command.
- Docs about stacktrace related commands (up, down, frame, backtrace).

## 3.4.2 - 2014-09-26
### Fixed
- Debugging commands invoked by ruby exectuable (#67), as in `byebug --
ruby -Itest test/controllers/posts_controller_test.rb -n
test_should_get_index`.


## 3.4.1 - 2014-09-25
### Fixed
- Use of threads inside `eval` command (#54).
- `list` command not listing backwards after reaching the end of the file.

## 3.4.0 - 2014-09-01
### Fixed
- deivid-rodriguez/pry-byebug#32 in a better way.


## 3.3.0 - 2014-08-28
### Fixed
- `set verbose` command.
- `set post_mortem false` command.
- Debugger stopping in `byebug`'s internal frames in some cases.
- `backtrace` crashing when `fullpath` setting disabled and calculated stack
size being smaller than the real one.

## Changed
- The `-t` option for `bin/byebug` now turns tracing on whereas the `-x` option
tells byebug to run the initialization file (.byebugrc) on startup. This is the
default behaviour though.
- `bin/byebug` libified and tests added.

### Removed
- `info locals` command. Use `var local` instead.
- `info instance_variables` command. Use `var instance` instead.
- `info global_variables` command. Use `var global` instead.
- `info variables` command. Use `var all` instead.
- `irb` command stepping capabilities, see
[8e226d0](https://github.com/deivid-rodriguez/byebug/commit/8e226d0).
- `script` and `restart-script` options for `bin/byebug`.

## 3.2.0 - 2014-08-02
### Fixed
- Remote debugging (#71), thanks @shuky19.
- `source` command (#68), thanks @Olgagr.
- `ruby-head` support (#71).

### Removed
- `post_mortem` activation through `Byebug.post_mortem`. Use `set post_mortem`
instead.
- `info stack` command. Use `where` instead.
- `method iv` command. Use `var instance` instead.
- Warning reported in #77.

## 3.1.2 - 2014-04-23
### Fixed
- (Really) `post_mortem` mode in `bin/byebug`.
- Line tracing in `bin/byebug`.

## 3.1.1 - 2014-04-23
### Fixed
- `post_mortem` mode in bin/byebug.

## 3.1.0 - 2014-04-23
### Removed
- `show commands` command. Use `history` instead.
- Byebug.start accepting options. Any program settings you want applied from
the start should be set in `.byebugrc`.
- `trace` command. Use `set linetrace` for line tracing and `tracevar` for
global variable tracing.
- `show version` command. Use `byebug --version` to check byebug's version.
- `set arg` setting. Use the `restart` command instead.

### Changed
- `linetrace_plus` setting renamed to `tracing_plus`.

### Added
- `history` command to check byebug's history of previous commands.

## 3.0.0 - 2014-04-17
### Fixed
- Plain `byebug` not working when `pry-byebug` installed.
- `post_mortem` mode.
- Command history not being saved after regular program termination.
- (Again) Calling `Byebug.start` with `Timeout.timeout` (#54), thanks
@zmoazeni!

### Added
- Allow disabling `post_mortem` mode.

### Changed
- `show commands` command for listing history of previous commands now behaves
like shell's `history` command.
- `show/set history filename` is now `show/set histfile`
- `show/set history size` is now `show/set histsize`
- `show/set history save` is now `show/set autosave`
- `finish` semantic, see
[61f9b4d](https://github.com/deivid-rodriguez/byebug/commit/61f9b4d).
- Use `per project` history file by default.

## Removed
- The `init` option for `Byebug.start`. Information to make the `restart`
command work is always saved now.

## 2.7.0 - 2014-02-24
- `IGNORED_FILES` slowing down startup (#52).
- Calling `Byebug.start` with `Timeout.timeout` (#53, #54).

## 2.6.0 - 2014-02-08
### Fixed
- Circular dependency affecting `pry-byebug` (thanks @andreychernih).

## 2.5.0 - 2013-12-14
### Added
- Support for `sublime-debugger`.

## 2.4.1 - 2013-12-05
### Fixed
- Installation error in Mac OSX (#40), thanks @luislavena.

## 2.4.0 - 2013-12-02
### Fixed
- `thread list` showing too many threads.
- Fix setting post mortem mode with "set post_mortem". Now this is the only
post mortem functionality available as specifying "Byebug.post_mortem" with a
block has been removed in this version.

### Added
- (Again) `debugger` as an alias to `byebug` (thanks @wallace).
- `-R` option for `bin/byebug` to specify server's hostname:port for remote
debugging (thanks @mrkn).

### Changed
- Use `require` instead of `require_relative` for loading byebug's extension
library (thanks @nobu).
- `trace variable $foo` should be now `trace variable $foo`.

## 2.3.1 - 2013-10-17
### Fixed
- Breakpoint removal.
- Broken test suite.

## 2.3.0 - 2013-10-09
### Added
- Compatibility with Phusion Passenger Enterprise (thanks @FooBarWidget).

### Changed
- More minimalist help system.

## 2.2.2 - 2013-09-25
### Fixed
- Compilation issue in 64 bit systems.

## 2.2.1 - 2013-09-24
### Fixed
- Compilation issue introduced in 2.2.0 (#26).

### Changed
- `show/set stack_trace_on_error` is now `show/set stack_on_error`.

## 2.2.0 - 2013-09-22
### Fixed
- Stack size calculations.
- Setting `post_mortem` mode.

### Added
- `verbose` setting for TracePoint API event inspection.

### Changed
- Warning free byebug.
- Allow `edit <filename>` without a line number.

## 2.1.1 - 2013-09-10
### Fixed
- Debugging code inside `-e` Ruby flag.

## 2.1.0 - 2013-09-08
### Fixed
- Remote debugging display.
- `eval` crashing when inspecting raised an exception (reported by @iblue).

### Changed
- `enable breakpoints` now enables every breakpoint.
- `disable breakpoints` now disables every breakpoint.

## 2.0.0 - 2013-08-30
### Added
- "Official" definition of a command API.
- Thread support.

### Removed
- `jump` command. It had never worked.

### Changed
- Varoius internal refactorings.

## 1.8.2 - 2013-08-16
### Fixed
- `save` command now saves the list of `displays`.
- Stack size calculation.

### Changed
- More user friendly regexps for commands.
- Better help for some commands.

## 1.8.1 - 2013-08-12
### Fixed
- Major regression introduced in 1.8.0.

## 1.8.0 - 2013-08-12
### Added
- Remote debugging support.

## 1.7.0 - 2013-08-03
### Added
- List command automatically called after callstack navigation commands.
- C-frames specifically marked in the callstack.
- C-frames skipped when navigating the callstack.

## 1.6.1 - 2013-07-10
### Fixed
- Windows compatibiliy: compilation and terminal width issues.

## 1.6.0 - 2013-07-10
### Fixed
- `byebug` placed at the end of a block or method call not working as expected.
- `autolist` being applied when Ruby `-e` option used.

### Changed
- Backtrace callstyles. Use `long` for detailed frames in callstack and `short`
for more concise frames.

## 1.5.0 - 2013-06-21
### Fixed
- Incomplete backtraces when the debugger was not started at program startup.

## 1.4.2 - 2013-06-20
### Fixed
- `help command subcommand` command.
- Interaction with Rails Console debugging flag.
- `post_mortem` mode when running byebug from the outset.
- `no-quit` flag when running byebug from the outset.

## 1.4.1 - 2013-06-15
### Fixed
- Crash when printing some filenames in backtraces.
- Allow byebug developers to easily use compilers different from gcc (thanks
@GarthSnyder!).

## 1.4.0 - 2013-06-05
### Fixed
- Memory leaks causing `byebug` to randomly crash.

### Changed
- Use the Debug Inspector API for backtrace information.

## 1.3.1 - 2013-06-02
### Fixed
- Interaction with Rails debugging flag.
- Crash when trying to print lines of code containing the character '%'.
- `basename` and `linetrace` options not working together.

## 1.3.0 - 2013-05-25
### Added
- Support colon-delimited include paths in command-line front-end (@ender672).

## 1.2.0 - 2013-05-20
### Fixed
- Ctrl+C during command line editing (works like pry/irb).

### Added
- `pry` command.

## 1.1.1 - 2013-05-07
### Added
- `pry-byebug` compatibility.

### Changed
- Better help system.
- Code cleanup.

## 1.1.0 - 2013-04-30
### Added
- Post Mortem support.

## 1.0.3 - 2013-04-23
### Fixed
- Negative line numbers shown by list command at the beginning of file.
- `backtrace` command segfaulting when trying to show info on some frame args.
Don't know the reason yet, but the exception is handled now and command does
not segfault anymore.

### Changed
- `autoreload` is set by default now.
- Try some thread support (not even close to usable).

## 1.0.2 - 2013-04-09
### Fixed
- backtraces messed up when using both `next`/`step` and backtrace navigation
commands.

### Changed
- `autolist` and `autoeval` are default settings now.

## 1.0.1 - 2013-04-06
### Fixed
- Byebug not loading properly.

## 1.0.0 - 2013-03-29
### Fixed
- Green test suite.

## 0.0.1 - 2013-03-18
### Added
- Initial release.
