set terminal svg
set output "result.svg"
plot "datasample.txt" using 1:2 w lp
