# ===----------------------------------------------------------------------=== #
#--- Введение в Mojo
# ===----------------------------------------------------------------------=== #
#RUN python and mojo functions
def main():
    print("---Mojo functions---")
    mojo()
    print("---Pyhon functions---")
    python_func()
    print("---Variables---")
    do_math(3)
    add_one(5)
    print("---Struct---")
    use_mypair()
    print("---Trait---")
    use_trait_function()
    print("---Parametrization---")
    call_repeat()
    print("---Integration Python---")
    #use_numpy()

###Функции

fn set_fire(owned text: String) -> String:
    # Mojo позволяет вам указать для каждого аргумента, должен ли он передаваться
    # по значению (как owned) или должен ли он передаваться по ссылке 
    # (как borrowed для неизменяемой ссылки или как inout для изменяемой ссылки)
    text += "🔥"
    return text

fn mojo():
    var x: String = "mojo"
    var y = set_fire(x)
    print(x)
    print(y)

def python_func():
    # CHECK: Hello Mojo 🔥!
    print("Hello Mojo 🔥!")
    for x in range(9, 0, -3):
        print(x)

#run mojo functions
#fn main():
#    mojo()

# Переменные
def do_math(x):
    var y = x + x
    y = y * y
    print(y)

def add_one(x):
    var y: Int = 1
    print(x + y)

# Структуры
struct MyPair:
    var first: Int
    var second: Int

    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second

    fn dump(self):
        print(self.first, self.second)

fn use_mypair():
    var mine = MyPair(2,4)
    mine.dump()

# Трейты(Признаки)
"""
Использование признаков позволяет писать универсальные функции, которые могут
принимать любой тип, соответствующий признаку, а не принимать только определенные типы.
"""
trait SomeTrait:
    """ 
    Создаем признак.
    """
    fn required_method(self, x: Int):
        pass

@value
struct SomeStruct(SomeTrait):
    """
    Структура соответствующая признаку.
    """
    fn required_method(self, x: Int):
        print("hello traits", x)

fn fun_with_traits[T: SomeTrait](x: T):
    x.required_method(42)

fn use_trait_function():
    var thing = SomeStruct()
    fun_with_traits(thing)

# Параметризация
"""
В Mojo параметр - это переменная времени компиляции, которая становится
константой времени выполнения и объявляется в квадратных скобках в функции
или структуре. Параметры позволяют выполнять метапрограммирование во время
компиляции, что означает, что вы можете генерировать или изменять
код во время компиляции. Многие другие языки используют "параметр" и "аргумент"
как взаимозаменяемые, поэтому имейте в виду, что когда мы говорим такие вещи,
как "параметр" и "параметрическая функция", мы говорим об этих параметрах
времени компиляции. Принимая во внимание, что "аргумент" функции - это значение
во время выполнения, которое объявляется в круглых скобках.
"""
fn repeat[count: Int](msg: String):
    for i in range(count):
        print(msg)

fn call_repeat():
    """
    Указывая count в качестве параметра, компилятор Mojo может оптимизировать
    функцию , поскольку это значение гарантированно не изменяется
    во время выполнения.
    """
    repeat[3]("Hello")
    # Prints "Hello 3 times"    

# Блоки и инструкции
def loop():
    """
    Отступы.
    """
    for x in range(5):
        if x % 2 == 0:
            print(x)

def print_line():
    """
    Все инструкции кода в Mojo заканчиваются символом новой строки. 
    Однако инструкции могут занимать несколько строк, если вы сделаете
    отступ в следующих строках. Например, эта длинная строка занимает две строки.
    """
    long_text = "This is a long line of text that is a lot easier to read if"
                " it is broken up across two lines instead of one long line."
    print(long_text)

# Комментарии к коду см. выше

# Интеграция с Python
from python import Python

fn use_numpy() raises:
    var np = Python.import_module("numpy")
    var ar = np.arange(15).reshape(3, 5)
    print(ar)
    print(ar.shape)