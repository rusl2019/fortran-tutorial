# Operators and flow control

One of the powerful advantages of computer algorithms, compared to simple mathematical formulae,
comes in the form of program _branching_ whereby the program can decide which instructions to
execute next based on a logical condition.

There are two main forms of controlling program flow:

- _Conditional_ (if): choose program path based on a boolean (true or false) value

- _Loop_: repeat a portion of code multiple times

# Logical operators

Before we use a conditional branching operator, we need to be able to form
a logical expression.

To form a logical expression, the following set of relational operators are available:

| Operator &nbsp; | Alternative &nbsp; | Description                                                     |
| :-------------: | :----------------: | --------------------------------------------------------------- |
|      `==`       |       `.eq.`       | Tests for equality of two operands                              |
|      `/=`       |       `.ne.`       | Test for inequality of two operands                             |
|      `> `       |       `.gt.`       | Tests if left operand is strictly greater than right operand    |
|      `< `       |       `.lt.`       | Tests if left operand is strictly less than right operand       |
|      `>=`       |       `.ge.`       | Tests if left operand is greater than or equal to right operand |
|      `<=`       |       `.le.`       | Tests if left operand is less than or equal to right operand    |

<br>

as well as the following logical operators:

| Operator &nbsp; | Description                                                          |
| :-------------: | -------------------------------------------------------------------- |
|     `.and.`     | TRUE if both left and right operands are TRUE                        |
|     `.or.`      | TRUE if either left or right or both operands are TRUE               |
|     `.not.`     | TRUE if right operand is FALSE                                       |
|     `.eqv.`     | TRUE if left operand has same logical value as right operand         |
|    `.neqv.`     | TRUE if left operand has the opposite logical value as right operand |