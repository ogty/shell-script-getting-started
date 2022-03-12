# Shell Script Getting Started

## Contents

- [Output]()
- [Format Strings]()
- [Positional Parameters]()
- [User Input]()
- [Reading File]()
- [Variables]()
- [If Statements]()
- [While Loop]()
- [For Loop]()
- [Case Statement]()
- [Functions]()

---

### Output

Writing to the screen 

```sh
echo 'Hello, world!'
printf 'Hello, world!'
```

### Format Strings

Format strings for `printf`

- %s : String
- %d : Decimal
- %f : Floating point
- %x : Hexadecimal
- \n : Newline
- \r : Carriage return
- \t : Horizontal tab

### Positional Parameters

Script parameters

- $# : Number of parameters
- $0 : Name of the script
- $1 : First parameter
- $2 : Second parameter ...

Default parameters

```sh
MYVAR=${1:-Cake}
```

Note: If parameter 1 is unset, the value of `MYVAR` will default to `Cake`

### User Input

Read from stdin

```sh
read MYVAR
```

Prompting

```sh
read -p 'Name: ' USERNAME
```

### Reading a File

```sh
while IFS="" read MYLINE
do
  echo "$MYLINE"
done < "somefile.txt"
```

Note: `IFS=""` preserves whitespace

### Variables

Declaring a Variable

```sh
MYVAR='Hello'
```

Referencing a Variable

```sh
echo $MYVAR
echo "$MYVAR, world!"
```

Assigning Shell Output

```sh
CMDOUT=$(pwd)
```

### If Statements

Command conditional(`cmd` will return `0` if success)

```sh
if cmd
then 
  some cmds
else
  other cmds
fi
```

File and numeric conditionals

```sh
if [[ -e $FILENAME ]]
then
  echo $FILENAME exists
fi
```

| File Test | Use |
| --- | --- |
| -d | Derectory exists |
| -e | File exists |
| -r | File is readable |
| -w | File is writable |
| -x | File is executable |

| Numeric Test | Use |
| --- | --- |
| -eq | Equal |
| -gt | Greater than |
| -lt | Less than |

### While Loop

```sh
i=0
while (( i < 1000 ))
do
  echo $i
  let i++
done
```

### For Loop

Numerical looping

```sh
for ((i=0; i < 1000; i++))
do
  echo $i
done
```

Iterating over a list

```sh
for VAL in 20 3 dog 7
do
  echo $VAL
done
```

### Case Statement

```sh
case $MYVAR in
  "carl")
    echo 'Hi Carl!'
    ;;
  "Paul")
    echo 'Hi Paul!'
    ;;
  *) # default
    echo 'Goodbye'
    exit
    ;;
esac
```

### Functions

Declaring a function

```sh
function myfun ()
{
  # function body
  echo 'This is myfunc()'
}
```

Invoking a function

```
myfun param1 param2
```
