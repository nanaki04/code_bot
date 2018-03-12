# CodeBot

Console application for generating boilerplate code and uml class maps.

usage:

```
$ cbot <input_file> <output_language>
```

## Installation

To run the command line tool, you will need to have erlang installed.

- mac: ```brew install erlang```
- linux: ```sudo apt-get erlang```
- (this tool does not have windows support atm)

To build the command line tool yourself, you need to have elixir installed.

- mac: ```brew install elixir```
- linux: ```sudo apt-get elixir```
- (this tool does not have windows support atm)

You can build the command line tool with the following command:

```
mix escript.build
```

To run the command line tool conveniently, it is probably a good idea to sudo cp it in a lib directory:

- mac: ```sudo cp cbot /usr/local/bin/cbot```
- linux: TODO

or alternatively add the installation path to your environment paths.

## Usage

```
$ cbot <input_file> <output_language>
```

Code bot currently can parse the following formats:

- [.uml, .plantuml, .plnt] plant uml syntax (default)
- [.ez] fast to write script created specifically for this tool

Code bot currently can output the following formats:

- c#
- unity (c# with monobehaviours and serialization)
- u# (alias for unity)
- php
- uml (plant uml)

## Examples

dummy.uml
```
@startuml
namespace Dummy.Namespace {
  class DummyClass {
    +int PublicInt // a public int
    -string PrivateString
    +float CalcRate(float val1, float val2) // calculate the rate
  }

  interface IDummyClass {
    +int PublicInt
    +float CalcRate(float val1, float val2)
  }

  enum ButtonType {
    OK
    Cancel
  }
}
@enduml
```

Generating c# from the above uml:

```
$ cbot dummy.uml c#
parsing input
generating cs files
Generated file: Dummy/Namespace/ButtonType.cs
Generated file: Dummy/Namespace/IDummyClass.cs
Generated file: Dummy/Namespace/DummyClass.cs
output generated in: /Users/robertjanzwetsloot/Projects/elixir/code_bot
```

DummyClass.cs

```
using System.Collections.Generic;
using UnityEngine;
using UniRx;

namespace Dummy.Namespace
{
    /// <summary>
    /// TODO
    /// </summary>
    public class DummyClass
    {
        /// <summary>
        /// TODO
        /// </summary>
        private string PrivateString;

        /// <summary>
        /// a public int
        /// </summary>
        public int PublicInt { get; private set; }

        /// <summary>
        /// constructor
        /// </summary>
        public DummyClass()
        {
            // TODO
        }

        /// <summary>
        /// calculate the rate
        /// </summary>
        /// <param name="val2"></param>
        /// <param name="val1"></param>
        public float CalcRate(float val2, float val1)
        {
            // TODO
        }

    }
}
```

generating php from the above uml:

```
$ cbot dummy.uml php
parsing input
generating php files
Generated file: Dummy/Namespace/ButtonType.php
Generated file: Dummy/Namespace/IDummyClass.php
Generated file: Dummy/Namespace/DummyClass.php
output generated in: /Users/robertjanzwetsloot/Projects/elixir/code_bot
```

DummyClass.php

```
<?php

namespace Dummy.Namespace;

/**
 * TODO
 * @package Dummy.Namespace
 */
class DummyClass
{
    /**
     * TODO
     * @var string
     */
    private $privateString

    /**
     * a public int
     * @var int
     */
    public $publicInt

    /**
     * calculate the rate
     * @param float $val2
     * @param float $val1
     * @return float
     */
    public function CalcRate(float val2, float val1): float
    {
        // TODO
    }
}
```

If you are like me, and find even plant uml too much effort to write, you can use ez script.
Ez scripts is a fast to write script specifically developped for this tool.
The above plant uml can be written in ez script as follows, and will produce the same output when generating with cbot.

Dummy.ez

```
ns Dummy.Namespace
	c DummyClass
		i PublicInt # a public int
		_s PrivateString
		f CalcRate(f val1, f val2) # calculate the rate
	if IDummyClass
		i PublicInt
		f CalcRate(f val1, f val2)
	e ButtonType
		OK
		Cancel
```

And you can generate code with the following command:

```
$ cbot Dummy.ez c#
```
