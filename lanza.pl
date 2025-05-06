#!/usr/bin/perl
#**************************************************************
#         		Pontificia Universidad Javeriana
#     Autor: Carlos Daniel Guiza
#     Fecha: 3 de Mayo de 2025
#     Materia: Sistemas Operativos
#     Tema: Taller de Evaluación de Rendimiento
#     Fichero: script automatización ejecución por lotes 
#	Descripcion: Fichero para la ejecucion de ejecutables
#****************************************************************/

$Path = `pwd`; #dolar es variable, pwd es para comunicarse con el SO. Imprime la carpeta en la que se encuentra
chomp($Path); #Chomp quita el salto de linea. Agarra solamente el valor

#Crear un arreglo que almacena los ejecutables a usar en el codigo
@Nombre_Ejecutable = ("mmClasicaFork", "mmClasicaOpenMP", "mmClasicaPosix");

#Un arreglo que representa los tamanos de matriz que se le pasaran al ejecutable
@Size_Matriz = ("256","512", "1024");

#UN arreglo de hilos. Muestra la cantidad de hilos que se probaran en la ejecucion.
@Num_Hilos = (1,2,4,8);

#Indica cuantas veces se repetiran cada combinacion de parametros
$Repeticiones = 30;

#Un bucle que itera en cada dato del arreglo de nombre de ejecutables
foreach $Nombre_Ejecutable (@Nombre_Ejecutable) {
    # Un bucle que itera en cada dato del arreglo de tamanos
    foreach $size (@Size_Matriz) {
        # Un bucle que itera en cada dato del arreglo de hilo
        foreach $hilo (@Num_Hilos) {
            # Crea una variable $file que contiene la ruta y nombre de un archivo de salida.
            # Combina la ruta, el nombre del ejecutable, el tamaño y los hilos.
            $file = "$Path/$Nombre_Ejecutable-" . $size . "-Hilos-" . $hilo . ".dat";

            # Bucle que ejecutara la cantidad de repeticiones que se hayan puesto, para asi guardar la informacion que salga del ejecutable
            for ($i = 0; $i < $Repeticiones; $i++) {
                # Ejecuta el comando en el sistema operativo usando 'system'.
                # Llama al ejecutable y guarda la info en el archivo con direccion a $file
                system("$Path/$Nombre_Ejecutable $size $hilo  >> $file");

                # printf("$Path/$Nombre_Ejecutable $size $hilo \n");
            }

            # Cierra el archivo
            close($file);

            $p = $p + 1;

            # Calcular el promedio de los tiempos almacenados en el archivo
	    my $suma = 0;
            my $conteo = 0;
            open(my $fh, '<', $file) or die "No se pudo abrir $file: $!";
	    while (my $linea = <$fh>) {
    		chomp($linea);
    		if ($linea =~ /(\d+)/) {
        		$suma += $1;
        		$conteo++;
    		}
	    }
	    close($fh);

	    # Calcular el promedio si hay datos
	    my $promedio = 0;
	    if ($conteo > 0) {
		$promedio = $suma / $conteo;
	    }

	   # Agregar el promedio al archivo
	   system("echo 'Promedio: $promedio ms' >> $file");
        }
    }
}

