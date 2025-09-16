import matplotlib.pyplot as plt
import pandas as pd
import os

# 设置工作目录
script_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(script_dir)

# 设置中文字体
plt.rcParams["font.family"] = ["SF Pro Display", "FZHei-B01"]

# 确保plots目录存在
if not os.path.exists("plots"):
    os.makedirs("plots")

# 读取CSV文件
freq_data = pd.read_csv("data/freq.csv")
ampl_data = pd.read_csv("data/ampl.csv")
phase_data = pd.read_csv("data/phase.csv")

# 绘制频率数据图
plt.figure(figsize=(10, 6))
plt.scatter(freq_data["Freq(Hz)"], freq_data["measure"], color="blue", s=50, alpha=0.7)
plt.plot(freq_data["Freq(Hz)"], freq_data["Freq(Hz)"], "r:", label="理想关系 (y=x)")
plt.xlabel("实际频率 (Hz)", fontsize=12)
plt.ylabel("测量频率 (Hz)", fontsize=12)
plt.legend()
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig("plots/freq_plot.svg")

# 绘制幅度数据图
plt.figure(figsize=(10, 6))
plt.scatter(ampl_data["Ampl(V)"], ampl_data["measure"], color="green", s=50, alpha=0.7)
plt.plot(ampl_data["Ampl(V)"], ampl_data["Ampl(V)"], "r:", label="理想关系 (y=x)")
plt.xlabel("实际幅度 (V)", fontsize=12)
plt.ylabel("测量幅度 (V)", fontsize=12)
plt.legend()
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig("plots/ampl_plot.svg")

# 绘制相位数据图
plt.figure(figsize=(10, 6))
plt.scatter(phase_data["Freq(Hz)"], phase_data["Phase(rad)"], color="orange", s=50, alpha=0.7)
plt.plot(phase_data["Freq(Hz)"], phase_data["Phase(rad)"], "r:")
plt.xlabel("频率 (Hz)", fontsize=12)
plt.ylabel("相位 (rad)", fontsize=12)
plt.legend()
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig("plots/phase_plot.svg")

# 绘制频率差值图
plt.figure(figsize=(10, 6))
freq_diff = freq_data["measure"] - freq_data["Freq(Hz)"]
plt.bar(freq_data["Freq(Hz)"], freq_diff, color="blue", alpha=0.7)
plt.axhline(y=0, color="r", linestyle=":", alpha=0.7)
plt.xlabel("实际频率 (Hz)", fontsize=12)
plt.ylabel("差值 (Hz)", fontsize=12)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig("plots/freq_diff_plot.svg")

# 绘制幅度差值图
plt.figure(figsize=(10, 6))
ampl_diff = ampl_data["measure"] - ampl_data["Ampl(V)"]
plt.bar(ampl_data["Ampl(V)"], ampl_diff, color="green", alpha=0.7, width=0.01)  # 调整宽度为 0.02
plt.axhline(y=0, color="r", linestyle=":", alpha=0.7)
plt.xlabel("实际幅度 (V)", fontsize=12)
plt.ylabel("差值 (V)", fontsize=12)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig("plots/ampl_diff_plot.svg")

print("图像已保存到 'plots' 文件夹中。")
print("差值图像已保存到 'plots' 文件夹中。")
