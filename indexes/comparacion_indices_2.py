
import matplotlib.pyplot as plt
import numpy as np

# Datos
labels = ['Antes del índice', 'Después del índice']
execution_times = [6.239, 3.486]  # ms

x = np.arange(len(labels))

plt.figure()
bars = plt.bar(x, execution_times, width=0.4)

# Etiquetas encima de cada barra
for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width() / 2,
        height,
        f'{height:.3f} ms',
        ha='center',
        va='bottom'
    )

plt.xticks(x, labels)
plt.ylabel('Execution Time (ms)')
plt.title('Comparación del tiempo de ejecución del query')

plt.tight_layout()
plt.show()
