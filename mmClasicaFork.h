/**************************************************************
#         		Pontificia Universidad Javeriana
#     Autor: Carlos Daniel Guiza
#     Fecha: 3 de Mayo de 2025
#     Materia: Sistemas Operativos
#     Tema: Taller de Evaluación de Rendimiento
#     Fichero: Programa plantilla de la multiplicacion de matrices con Fork
#	Descripcion: Programa modularizado en donde se definen los metodos de multiplicacion de matrices y paralelismo con Fork
#****************************************************************/

#ifndef MM_CLASICA_FORK_H
#define MM_CLASICA_FORK_H

#include <sys/time.h>

// Definicion de las variables globales
extern struct timeval inicio, fin;

void InicioMuestra();
void FinMuestra();
void multiMatrix(double *mA, double *mB, double *mC, int D, int filaI, int filaF);
void impMatrix(double *matrix, int D);
void iniMatrix(double *mA, double *mB, int D);

#endif
