#include <stdio.h>
#include <string.h>
#include <cmath>
#include <cstdlib>      
#include <iostream>
#include <fstream>
#include <vector>
#include <iomanip>
#include <string>
#include <algorithm>
#include <map>
#include <set>
#include <utility>

// supposed to be compiled with: R CMD SHLIB mulLibs.cc
// to create the .so (shared object)                        

using namespace std ;

int ref ;
vector <int> clusters ;
vector <double> buffer ;
set <int> cluster_name ;             
multimap<int, double> cluster_to_data ;
map <int, double> cluster_to_means ;
map <int, double> cluster_to_std_devs ;
map <int, double> cluster_to_variances ;
map <int, double> cluster_to_SS ;
multimap <int, double> cluster_to_size ;

// function calculating mean
double Mean ( vector <double> array, double N ) {
	
	double sum = 0.0f ;
	for (int i = 0; i < N; i++)
		sum = sum + array [i];
	return ( sum / N ) ;

} 

// function calculating harmonic mean
double Harmonic_Mean ( vector <double> array, double N ) {

        double sum = 0 ;
        for (int i = 0; i < N; i++)
        	sum = sum + ( 1 / array [i] ) ;
        return ( N / sum ) ;

}

// function calculating standard deviation
double Std_dev ( vector <double> array, double N ) {

	double sum = 0.0f ;
	double STD_DEV = 0.0f ; // returning zero's
	
	for (int i = 0; i < N; i++)
	{
		sum = sum + array [i];
		STD_DEV = STD_DEV + pow( array [i], 2 );
	}

	double tmp = STD_DEV - ( N * pow ( sum / N , 2 ) ) ;
	tmp = tmp / ( N -1 ) ;
	return sqrt ( tmp ) ;
}

// function calculating variance
double Variance ( vector <double> array, double N ) {

        double sum = 0.0f ;
        double STD_DEV = 0.0f ; // returning zero's

        for (int i = 0; i < N; i++)
        {
                sum = sum + array [i];
                STD_DEV = STD_DEV + pow( array [i], 2 );
        }

        double tmp = STD_DEV - ( N * pow ( sum / N , 2 ) ) ;
        tmp = tmp / ( N -1 ) ;
        return tmp ;
}


// function calculating Sum_of_Squares
double SS ( vector <double> array, double N ) {
        
        double sum = 0.0f ;
		double sum_squares = 0.0f ;
        
        for (int i = 0; i < N; i++)
        {
                sum = sum + array [i];
                sum_squares = sum_squares + pow( array [i], 2 );                        
        }

        double tmp = sum_squares - pow ( sum , 2 ) / N ;
		
        return tmp ;
}


extern "C" {
	
	// ===================================================
	//
	// Function fast_mean
	//
	// ===================================================

	// intended to be called as:
	// .C("fast_mean", as.double( data ), as.double( means ) , as.integer( n ), as.integer( m ), as.integer( groups ) , as.integer ( reference ) )

	void fast_mean ( double *data, double *means, int *N , int *M, int *groups, int *reference ) {
	
		// store cluster positions and names
		// remember that: 
		// n <- as.integer( (dim(a))[1] )
		// m <- as.integer( (dim(a))[2] )

		cluster_to_means.clear() ;
                cluster_to_data.clear() ;
		clusters.clear() ;
		cluster_name.clear() ;

		ref = *reference ;
		int index = 0 ;
        
		for ( int i = 0 ; i < *M ; i++ ) {

			clusters.push_back( groups[i] ) ;
			cluster_name.insert( groups[i] ) ;
        
		}

		// upload data from the original R structures

		// loop over all the original lines with data 
		double tmp = 0.0f ;
		int current_cluster ;
		int jump = *N ;

		for ( int i = 0 ; i < *N ; i++ ) {

			// loop over all the samples ( groups ) 			

			for ( int j = 0 ; j < *M ; j++ ) {
			
				current_cluster = clusters[j] ;
				tmp = data[ i + jump * j ] ; 

                        	cluster_to_data.insert( std::pair<int, double> ( current_cluster, tmp ) ) ;
                                         
			}

			// NOW PROCESS DATA
        
			pair<multimap<int, double>::iterator, multimap<int, double>::iterator> ppp;
                
			// loop over all the cluster names
			for ( set <int>::iterator it = cluster_name.begin() ; it != cluster_name.end() ; ++it ) {

				// select only data belonging to the same cluster
				ppp = cluster_to_data.equal_range( *it );

				// fill buffer vector
				buffer.clear() ;
				for ( multimap<int, double>::iterator it2 = ppp.first ; it2 != ppp.second ; ++it2 ) {

					buffer.push_back( (*it2).second ) ;

				}
                                         
 				// evaluate Mean
				cluster_to_means.insert(std::pair<int ,double>( *it , Mean ( buffer, buffer.size() ) ) ) ;

			}
                        
			// loop over all the Means and evaluate differences with respect to Ref
                                        
			for( map<int, double>::iterator ii = cluster_to_means.begin(); ii != cluster_to_means.end() ; ++ii ) {

				if ( (*ii).first != ref ) {

					means[index] = ( (*ii).second - cluster_to_means[ ref ] ) ;
					index++ ;

				}
			}

			cluster_to_means.clear() ;
			cluster_to_data.clear() ; // end of a line of data

		}

	}	

        // ===================================================
        //
        // Function fast_sd
        //
        // ===================================================

        // intended to be called as:
        // .C("fast_sd", as.double( data ), as.double( std_devs ) , as.integer( n ), as.integer( m ), as.integer( groups )  )

        void fast_sd ( double *data, double *std_devs, int *N , int *M, int *groups ) {

                // store cluster positions and names
                // remember that: 
                // n <- as.integer( (dim(a))[1] )
                // m <- as.integer( (dim(a))[2] )

				cluster_to_std_devs.clear() ;
				cluster_to_data.clear() ;
                clusters.clear() ;
                cluster_name.clear() ;

                int index = 0 ;

                for ( int i = 0 ; i < *M ; i++ ) {

                        clusters.push_back( groups[i] ) ;
                        cluster_name.insert( groups[i] ) ;

                }

                // upload data from the original R structures

                // loop over all the original lines with data 
                double tmp = 0.0f ;
                int current_cluster ;
                int jump = *N ;

                for ( int i = 0 ; i < *N ; i++ ) {

                        // loop over all the samples ( groups )                         

                        for ( int j = 0 ; j < *M ; j++ ) {

                                current_cluster = clusters[j] ;
                                tmp = data[ i + jump * j ] ;

                                cluster_to_data.insert( std::pair<int, double> ( current_cluster, tmp ) ) ;

                        }
        
                        // NOW PROCESS DATA
        
                        pair<multimap<int, double>::iterator, multimap<int, double>::iterator> ppp;   

                        // loop over all the cluster names
                        for ( set <int>::iterator it = cluster_name.begin() ; it != cluster_name.end() ; ++it ) {
                
                                // select only data belonging to the same cluster
                                ppp = cluster_to_data.equal_range( *it );
                
                                // fill buffer vector
                                buffer.clear() ;
                                for ( multimap<int, double>::iterator it2 = ppp.first ; it2 != ppp.second ; ++it2 ) {
                
                                	buffer.push_back( (*it2).second ) ;
                                }

                                // evaluate Std_dev
				cluster_to_std_devs.insert(std::pair<int ,double>( *it , Std_dev ( buffer, buffer.size() ) ) ) ;
                        
                        }

                        // loop over all the Std_devs and store them
                        for( map<int, double>::iterator ii = cluster_to_std_devs.begin(); ii != cluster_to_std_devs.end() ; ++ii ) {
                                
                                        std_devs[index] = (*ii).second ;
					index++ ;                
                        }

                        cluster_to_std_devs.clear() ;
                        cluster_to_data.clear() ; // end of a line of data

                }

	}

        // ===================================================
        //
        // Function fast_var
        //
        // ===================================================

        // intended to be called as:
        // .C("fast_var", as.double( data ), as.double( std_devs ) , as.integer( n ), as.integer( m ), as.integer( groups )  )

        void fast_var ( double *data, double *std_devs, int *N , int *M, int *groups ) {

                // store cluster positions and names
                // remember that:
                // n <- as.integer( (dim(a))[1] )
                // m <- as.integer( (dim(a))[2] )

                cluster_to_variances.clear() ;
                cluster_to_data.clear() ;
                clusters.clear() ;
                cluster_name.clear() ;

                int index = 0 ;

                for ( int i = 0 ; i < *M ; i++ ) {

                        clusters.push_back( groups[i] ) ;
                        cluster_name.insert( groups[i] ) ;

                }

                // upload data from the original R structures

                // loop over all the original lines with data
                double tmp = 0.0f ;
                int current_cluster ;
                int jump = *N ;

                for ( int i = 0 ; i < *N ; i++ ) {

                        // loop over all the samples ( groups )

                        for ( int j = 0 ; j < *M ; j++ ) {

                                current_cluster = clusters[j] ;
                                tmp = data[ i + jump * j ] ;

                                cluster_to_data.insert( std::pair<int, double> ( current_cluster, tmp ) ) ;

                        }

                        // NOW PROCESS DATA

                        pair<multimap<int, double>::iterator, multimap<int, double>::iterator> ppp;

                        // loop over all the cluster names
                        for ( set <int>::iterator it = cluster_name.begin() ; it != cluster_name.end() ; ++it ) {

                                // select only data belonging to the same cluster
                                ppp = cluster_to_data.equal_range( *it );

                                // fill buffer vector
                                buffer.clear() ;
                                for ( multimap<int, double>::iterator it2 = ppp.first ; it2 != ppp.second ; ++it2 ) {

                                        buffer.push_back( (*it2).second ) ;
                                }

                                // evaluate Std_dev
                                cluster_to_variances.insert(std::pair<int ,double>( *it , Variance ( buffer, buffer.size() ) ) ) ;

                        }

                        // loop over all the Std_devs and store them
                        for( map<int, double>::iterator ii = cluster_to_variances.begin(); ii != cluster_to_variances.end() ; ++ii ) {

                                        std_devs[index] = (*ii).second ;
                                        index++ ;
                        }

                        cluster_to_variances.clear() ;
                        cluster_to_data.clear() ; // end of a line of data

                }

        }

        // ===================================================
        //
        // Function fast_harmonic
        //
        // ===================================================

        // intended to be called as:
        // .C("fast_harmonic_sample_size", as.double( harmonic_means ) , as.integer( m ), as.integer( groups ) , as.integer ( reference ) )

	// this function compute harmonic means of the sample's size (between a certain sample i and the Reference sample)

	void fast_harmonic_sample_size ( double *harmonic_means, int *M , int *groups, int *reference ) {

                // store cluster positions and names
                // remember that: 
                // m <- as.integer( (dim(a))[2] )
        
                cluster_name.clear() ;
		cluster_to_size.clear() ;

		int index = 0 ;

                for ( int i = 0 ; i < *M ; i++ ) {

                        cluster_name.insert( groups[i] ) ;
			cluster_to_size.insert( std::pair<int, double> ( groups[i], 1.0f ) ) ;
                }

		// loop over all the cluster names
		for ( set <int>::iterator it = cluster_name.begin() ; it != cluster_name.end() ; ++it ) {

			buffer.clear() ;		

			if ( (*it) != ref ) {

				buffer.push_back( cluster_to_size.count( ref ) ) ; 

        	        	// select only data belonging to the same cluster

				buffer.push_back( cluster_to_size.count( *it ) ) ;

				// compute harmonic mean
				harmonic_means[index] = Harmonic_Mean ( buffer, buffer.size() ) ;
			
				index++ ;
	               }
		}
	}
	

        // ===================================================
        //
        // Function fast_SS
        //
        // ===================================================

        // intended to be called as:
        // .C("fast_SS", as.double( data ), as.double( ss ) , as.integer( n ), as.integer( m ), as.integer( groups )  )

        void fast_SS ( double *data, double *ss, int *N , int *M, int *groups ) {

                // store cluster positions and names
                // remember that:
                // n <- as.integer( (dim(a))[1] )
                // m <- as.integer( (dim(a))[2] )

                cluster_to_SS.clear() ;
                cluster_to_data.clear() ;
                clusters.clear() ;
                cluster_name.clear() ;

                int index = 0 ;

                for ( int i = 0 ; i < *M ; i++ ) {

                        clusters.push_back( groups[i] ) ;
                        cluster_name.insert( groups[i] ) ;

                }

                // upload data from the original R structures

                // loop over all the original lines with data
                double tmp = 0.0f ;
                int current_cluster ;
                int jump = *N ;

                for ( int i = 0 ; i < *N ; i++ ) {

                        // loop over all the samples ( groups )

                        for ( int j = 0 ; j < *M ; j++ ) {

                                current_cluster = clusters[j] ;
                                tmp = data[ i + jump * j ] ;

                                cluster_to_data.insert( std::pair<int, double> ( current_cluster, tmp ) ) ;

                        }

                        // NOW PROCESS DATA

                        pair<multimap<int, double>::iterator, multimap<int, double>::iterator> ppp;

                        // loop over all the cluster names
                        for ( set <int>::iterator it = cluster_name.begin() ; it != cluster_name.end() ; ++it ) {

                                // select only data belonging to the same cluster
                                ppp = cluster_to_data.equal_range( *it );

                                // fill buffer vector
                                buffer.clear() ;
                                for ( multimap<int, double>::iterator it2 = ppp.first ; it2 != ppp.second ; ++it2 ) {

                                        buffer.push_back( (*it2).second ) ;
                                }

                                // evaluate SS
                                cluster_to_SS.insert(std::pair<int ,double>( *it , SS ( buffer, buffer.size() ) ) ) ;

                        }

                        // loop over all the SS and store them
                        for( map<int, double>::iterator ii = cluster_to_SS.begin(); ii != cluster_to_SS.end() ; ++ii ) {

                                        ss[index] = (*ii).second ;
										index++ ;
                        }

                        cluster_to_SS.clear() ;
                        cluster_to_data.clear() ; // end of a line of data

                }

        }
		
	// ===================================================
	//
	// Function fast_mulCalc
	//
	// ===================================================

	// intended to be called as:
	// .C("fast_mulCalc", as.double( Mulcom_P_FC ), as.double( Mulcom_P_MSE_Corrected ), as.double( t ), as.double( m ), as.integer( num_comparison ), as.integer( num_geni ), as.integer( v ) )
		
	void fast_mulCalc ( double *Mulcom_P_FC, double *Mulcom_P_MSE_Corrected, double *t, double *m, int *num_comparison, int *num_geni, int *v ) {	

		buffer.clear() ;
		double local_t = *t ; 
		double local_m = *m ;
		int dim =  (*num_comparison) * (*num_geni) ;

		for ( int i = 0 ; i < dim ; i++ ) {

			buffer.push_back( abs ( Mulcom_P_FC[i] ) - Mulcom_P_MSE_Corrected[i] * local_t ) ;

		}
	
		// loop over all the buffer items and see, for each comparison:
		// b[which(d > m)] <- 1
		
		vector <int> b ;
		for ( int i = 0 ; i < dim ; i++ ) {

			if ( buffer[i] > local_m ) { b.push_back( 1 ) ; }
			else  {  b.push_back( 0 ) ; }
		}
		
		// create vector with results
		for ( int i = 0 ; i <  *num_comparison ; i++ ) {
			v[i] = 0 ;
 		}		
  
                int jump = *num_comparison ;
                for ( int i = 0 ; i < (*num_comparison) ; i++  ) {
                        for ( int j = 0 ; j < (*num_geni) ; j++ ) {

                                if ( b[ i + jump * j ] > 0 ) { v[i] += 1 ; }

                        }
                }	
	}
	
	// END OF LIBRARY
}

