# Magnetic Levitation System  
## Modeling, Linearization and Controllability Analysis

**Author:** Muhammad Ibrahim Zubair  
**Date:** 2026  

---

### 1. Physical Model

The magnetic levitation (Maglev) system consists of an electromagnet that generates a force to suspend a ferromagnetic object against gravity.

**Parameters:**
- \( m \) : mass of the levitated object (0.1 kg)
- \( z \) : air-gap position (m)
- \( i \) : coil current (A)
- \( u \) : applied voltage (control input, V)
- \( R = 1\,\Omega \) : coil resistance
- \( L = 0.05\,\text{H} \) : coil inductance
- \( k \) : magnetic force constant
- \( g = 9.8\,\text{m/s}^2 \)

Magnetic force:
\[
F = k \frac{i^2}{z^2}
\]

---

### 2. Governing Equations

**Electrical subsystem:**
\[
u = L \frac{di}{dt} + R i
\]

**Mechanical subsystem:**
\[
m \ddot{z} = m g - k \frac{i^2}{z^2}
\]

---

### 3. Nonlinear State-Space Representation

Define the states:
- \( x_1 = z \) (position)
- \( x_2 = \dot{z} \) (velocity)
- \( x_3 = i \) (current)

The nonlinear state equations are:

\[
\begin{aligned}
\dot{x}_1 &= x_2 \\
\dot{x}_2 &= g - \frac{k x_3^2}{m x_1^2} \\
\dot{x}_3 &= -\frac{R}{L} x_3 + \frac{1}{L} u
\end{aligned}
\]

---

### 4. Equilibrium Point

At equilibrium (\( \dot{x} = 0 \), \( x_2 = 0 \)):

\[
i_0 = z_0 \sqrt{\frac{m g}{k}}, \qquad u_0 = R i_0
\]

Using the operating point \( z_0 = 0.05\,\text{m} \), \( i_0 = 0.7\,\text{A} \):

- \( u_0 = 1.4\,\text{V} \)
- Force constant \( k \) is computed from the equilibrium force balance.

---

### 5. Jacobian Linearization

The system is linearized about the equilibrium point by computing the Jacobian matrices:

\[
A = \left. \frac{\partial f}{\partial x} \right|_{(x_0,u_0)}, \quad
B = \left. \frac{\partial f}{\partial u} \right|_{(x_0,u_0)}
\]

Resulting linearized matrices:

\[
A = \begin{bmatrix}
0 & 1 & 0 \\
3924 & 0 & -28.03 \\
0 & 0 & -40
\end{bmatrix}, \quad
B = \begin{bmatrix}
0 \\ 0 \\ 20
\end{bmatrix}
\]

Final linearized model:
\[
\Delta \dot{x} = A \Delta x + B \Delta u
\]

---

### 6. Controllability Analysis

Controllability matrix:
\[
\mathcal{C} = \begin{bmatrix} B & AB & A^2 B \end{bmatrix}
\]

Computed values:
\[
AB = \begin{bmatrix} 0 \\ -560.6 \\ -800 \end{bmatrix}, \quad
A^2 B = \begin{bmatrix} -560.6 \\ 22422 \\ 32000 \end{bmatrix}
\]

\[
\mathcal{C} = \begin{bmatrix}
0 & 0 & -560.6 \\
0 & -560.6 & 22422 \\
20 & -800 & 32000
\end{bmatrix}
\]

\[
|\mathcal{C}| = 6.78 \times 10^6 \neq 0
\]

**Conclusion:** The linearized system is **fully controllable**.

---

### 7. Stability Analysis

The eigenvalues of the linearized A matrix are:

\[
\lambda = \{ +62.64,\ -62.64,\ -40 \}
\]

The presence of a positive real eigenvalue (\( +62.64 \)) confirms that the open-loop system is **unstable**. This is a characteristic feature of magnetic levitation systems and is the primary reason that active feedback control (such as PID or Model Predictive Control) is required.

An open-loop simulation starting from a small position disturbance (1 mm) shows that the position error grows exponentially, visually confirming the instability (see `matlab/open_loop_instability.m`).

### 8. Significance

This analysis establishes that the magnetic levitation system:
- Is open-loop unstable (confirmed by eigenvalue analysis and open-loop simulation)
- Is fully controllable (confirmed by the rank of the controllability matrix)
- Can therefore be stabilized using full-state feedback or advanced techniques such as Model Predictive Control (MPC)
- Provides a solid foundation for subsequent controller design and performance comparison with PID control

---

**Author Contact**  
Muhammad Ibrahim Zubair  
imuhammad085@gmail.com  
ORCID: 0000-0001-9297-7385
