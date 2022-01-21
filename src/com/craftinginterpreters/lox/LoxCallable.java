package com.craftinginterpreters.lox;

import java.util.List;

interface LoxCallable {
    String toString();
    int arity();
    Object call(Interpreter interpreter, List<Object> arguments);
}
