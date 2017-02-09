"""
# OriginalBCG

### *From BIT Numerical Mathematics 2016 Ji[158]*

### ArgumentList
* `A`: Matrix A n x n
* `B`: Matrix B n x s
* `X0`: Initial guess n x s
* `M`: preconditioner n x n
* `tol`: tolerance Real Number
* `maxit`: maximum number of iterations Real Number (obviously Z not R?????? how can you have non integer iterations????)

Returns: an approximate solution `Xsol` n x s
"""
function  OriginalBCG(A,B,X0,M,tol,maxit)
  R0 = B - A*X0;
  Z0 = M*R0;
  P0 = Z0*gamma0;
  a = zeroes(maxit);
  for i = 0 : (maxit - 1)
    a[i]  = (P0)
  end
end

A = [15 5 4 3 2 1; 5 35 9 8 7 6; 4 9 46 12 11 10; 3 8 12 50 14 13; 2 7 11 14 19 15; 1 6 10 13 15 45]
M = eye(6)

@printf("Case 1\n\tThe residual matrix Ri without rank deficiency")
R0 = [1 0.537266261211281;2 0.043775211060964;3 0.964458562037146;4 0.622317517840541;5 0.552735938776748;6 0.023323943544997]

@printf("Case2\n\tColumns in the initial block residual R0 are linearly dependent")
R0 = [1 10;2 20;3 30;4 40;5 50;6 60]

@printf("Case 3\n\tConvergence of one or more but not all columns in the residual matrix Ri")
R0 = [1 0.027212780358615;2 0.117544343373396;3 0.140184539179715;4 0.605659566833592;5 0.323269030695212;6 0.590821508384101]

@printf("Case 4\n\tcolumns in the residual matrix Ri become linearly dependent during BFBCG iterations")
R0 = [1 − 8.888614458250306;2 − 10.999025290685955;3 − 19.339674247091921;4 − 10.289152668326622;5 18.107579559267656;6 − 8.930794511222629]
