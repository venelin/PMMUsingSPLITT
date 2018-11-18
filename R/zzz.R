# zzz.R
# PMMUsingSPLITT
# 
# Copyright 2018 Venelin Mitov
# 
# This file is part of SPLITT: a generic C++ library for Serial and Parallel
# Lineage Traversal of Trees.
# 
# SPLITT is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
# 
# SPLITT is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public
# License along with SPLITT.  If not, see
# <http://www.gnu.org/licenses/>.
# 
# @author Venelin Mitov


#' Rcpp module for the \code{TraversalTaskAbcPMM}-class
#' @name PMMUsingSPLITT__TraversalTaskAbcPMM
#' @aliases Rcpp_PMMUsingSPLITT__TraversalTaskAbcPMM-class
NULL

#' \code{TraversalAlgorithm}-type used in \code{AbcPMM}
#' @name PMMUsingSPLITT__AbcPMM__AlgorithmType
#' @aliases Rcpp_PMMUsingSPLITT__AbcPMM__AlgorithmType-class
NULL

#' Base class for \code{PMMUsingSPLITT::AbcPMM::AlgorithmType}
#' @name PMMUsingSPLITT__AbcPMM__TraversalAlgorithm
#' @aliases Rcpp_PMMUsingSPLITT__AbcPMM__TraversalAlgorithm-class 
#' @slot algorithm algorithm.
NULL

# loading the RCPP C++ modules
loadModule( "PMMUsingSPLITT__TraversalTaskAbcPMM", TRUE )
