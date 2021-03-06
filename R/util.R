.onLoad = function(libname, pkgname){
	options(allocation.prec.bits = 256)
	options(allocation.print.decimals = 4)
	options(allocation.algIV.tol = 1e-10)
}

normalize = function(x)
{
	x / sum(x)
}

printf = function(msg, ...)
{
	cat(sprintf(msg, ...))
}

#' @importFrom Rmpfr asNumeric formatMpfr
my_format = function(x, decimal_digits = getOption("allocation.print.decimals"))
{
	L = length(x)

	idx_notna = which(!is.na(x) & abs(x) > 1)
	whole_digits = rep(1,L)
	whole_digits[idx_notna] = asNumeric(ceiling(log10(abs(x[idx_notna]))))
	print_digits = whole_digits + decimal_digits

	out = numeric(L)
	for (l in 1:L) {
		out[l] = formatMpfr(x[l], digits = print_digits[l], big.mark = ",")
	}
	return(out)
}


#' @title
#' Accessor for Solved Allocation
#' 
#' @description 
#' Extract the solved allocation from the result of an an allocation method.
#' 
#' @param object Result from an allocation method
#'
#' @return A numeric vector; each element contains the allocation for the
#' corresponding stratum.
#' @export
alloc = function(object)
{
	UseMethod("alloc")
}
