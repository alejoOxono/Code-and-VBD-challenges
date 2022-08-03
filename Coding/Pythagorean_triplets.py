def get_fibo(a, b, c, control):
    if (a-control) == 0:
        lista.append(str(b+c))
    else:
        return get_fibo(a, c, b+c, control+1)


def ciclo(a, b, c, control):
    while control != 0:
        get_fibo(a, b, c, control)
        control = control -1

lista = []
a, b, c = [int(i) for i in raw_input().split()]
ciclo(a, b, c, a)
print(' '.join(lista))


    