extends Node

# Основной класс для работы с комплексными числами в квантовых вычислениях
class Cx:
	# Действительная (real) и мнимая (imaginary) части числа
	var re : float  # real part (действительная часть)
	var im : float  # imaginary part (мнимая часть)
	
	# Конструктор комплексного числа
	func _init(real, imag):
		self.re = real
		self.im = imag
	
	# Преобразование в строку для красивого вывода
	func _to_string():
		if self.im >= 0:
			return "%7.4f + %6.4fi" % [self.re, self.im]  # Пример: "1.0000 + 2.5000i"
		else:
			return "%7.4f - %6.4fi" % [self.re, abs(self.im)]  # Пример: "1.0000 - 2.5000i"
	
	# --------------- ОСНОВНЫЕ ОПЕРАЦИИ ---------------
	
# Сложение двух комплексных чисел (a + b)
static func add(a, b : Cx) -> Cx:
	return Cx.new(a.re + b.re, a.im + b.im)

# Умножение двух комплексных чисел (a * b)
# Формула: (a.re*b.re - a.im*b.im) + (a.re*b.im + a.im*b.re)i
static func mul(a, b : Cx) -> Cx:
	var real = a.re*b.re - a.im*b.im  # Действительная часть произведения
	var imag = a.re*b.im + a.im*b.re  # Мнимая часть произведения
	return Cx.new(real, imag)

# Комплексно-сопряженное число (меняет знак мнимой части)
static func conjugate(z : Cx) -> Cx:
	return Cx.new(z.re, -z.im)

# Квадрат модуля комплексного числа (|z|² = re² + im²)
# Важно: это НЕ модуль, а именно его квадрат (используется в квантовых вероятностях)
static func sqabs(z : Cx) -> float:
	return z.re*z.re + z.im*z.im

# --------------- ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ---------------

# Преобразование действительного числа в комплексное (добавляет нулевую мнимую часть)
static func cast(x) -> Cx:
	return Cx.new(x, 0)

# Порог для сравнения чисел с плавающей точкой
const tresh = 0.0001

# Проверка равенства двух комплексных чисел (с учетом погрешности tresh)
static func eq(a, b : Cx) -> bool:
	return abs(a.re - b.re) < tresh and abs(a.im - b.im) < tresh

# Проверка равенства квадратов модулей (|a|² ≈ |b|²)
# Используется для сравнения квантовых состояний с точностью до фазы
static func eq_abs(a, b : Cx) -> bool:
	return abs(sqabs(a) - sqabs(b)) < tresh

# Проверка поэлементного равенства двух массивов комплексных чисел
static func eqlist(a_list, b_list) -> bool:
	if len(a_list) != len(b_list): 
		return false
	for i in len(a_list):
		if not eq(a_list[i], b_list[i]):
			return false
	return true

# Проверка равенства массивов по квадратам модулей
static func eqlist_abs(a_list, b_list) -> bool:
	if len(a_list) != len(b_list): 
		return false
	for i in len(a_list):
		if not eq_abs(a_list[i], b_list[i]):
			return false
	return true
