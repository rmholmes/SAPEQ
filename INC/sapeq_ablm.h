/* T
** Basin-wide header
**
** Options for ROMS Pacific Equatorial Simulation Coupled to Simple
** Atmosphere for simplified ENSO simulations (ENSPEQ)
**
** Ryan Holmes Feb 2017.
*/

/* Basic Model setup: */
 
#define SOLVE3D
#define UV_ADV
#define UV_COR
#define DJ_GRADPS
#define SPHERICAL
#define NONLIN_EOS
#define SALINITY
#define MASKING

#define SPLINES_VDIFF
#define SPLINES_VVISC
#define RI_SPLINES

/* ADVECTION */
#define TS_U3HADVECTION

/* DIFFUSION */
#define TS_DIF2
#define MIX_S_TS
#define UV_VIS4
#define MIX_S_UV

#define LMD_MIXING
#ifdef LMD_MIXING
# define LMD_RIMIX
# define LMD_CONVEC
# define LMD_DDMIX
# define LMD_SKPP
# undef LMD_BKPP
# define LMD_NONLOCAL
# define LMD_SHAPIRO
#endif

/* FLT/DIAG/AVG/STA outputs */
#undef FLOATS
#undef DIAGNOSTICS_UV
#define DIAGNOSTICS_TS
#define DIAGNOSTICS_TS_VDIF
#undef STATIONS
#define AVERAGES

/* BOUNDARY CONDITIONS */
#define RADIATION_2D 

/* ANALYTICALS/FORCING */

#define SRELAXATION
#define ANA_RAIN
#undef EMINUSP /* Calculate evaporation */

#undef ANA_NUDGCOEF
#undef ANA_SSFLUX
#undef ANA_STFLUX
#undef ANA_SMFLUX
#undef ANA_GRID
#undef ANA_CLOUD
#undef LONGWAVE
#define DIURNAL_SRFLUX 
#undef RELATIVE_HUMIDITY /* Activate if input is relative
                            humidity,otherwise it's assumed to be
                            specific humidity in g/kg. */
#undef ADD_WWB
#undef SHIFT_WWB
#define ANA_BSFLUX
#define ANA_BTFLUX
#define UV_QDRAG

#undef STATS_ENSO /* ENSO STATS FORCING OPTION */
#undef SVD_ENSO /* Use SVD modes for STATS_ENSO */

#define BULK_FLUXES
#define SOLAR_SOURCE

#define SET_WINDSPEED /* Set wind speed magnitude separately from Uwind and Vwind */
#undef SET_WINDQUAD
#define LONGWAVE_OUT
#define BULK_STRESS /* Use set wind stresses but BULK_FLUXES for heat flux */
#define ABLM /* Atmospheric boundary layer option */
#define ABLM_WATER /* Atmospheric boundary layer Qair */
#define ABLM_CONVTHR /* Atmospheric boundary layer convective threshold */
#define ABLM_BLHVAR /* Variable atmospheric boundary layer depth from file */
#undef ABLM_RELHUM /* Activate to tell ABLM that input is relative humidity */
