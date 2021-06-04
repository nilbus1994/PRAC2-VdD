library(readr)
library(dplyr)

# Creamos un DF a partir del fichero obtenido de Kaggle
DF <- read_csv("C:/Users/nil.busquets/Dropbox/UOC/UOC 2B/Visualización de datos/PRAC 2/KaggleV2-May-2016.csv")

# Observamos los campos y sus tipos del dataframe
summary(DF)

# Creamos la nueva columna del tiempo de espera entre el dia que se pide la cita y el dia de la cita.
DF$WaitingTime <- with(DF, as.Date(DF$AppointmentDay) - as.Date(substr(DF$ScheduledDay,1,10)))

# Creamos una nueva columna con el valor de la hora (24h) en el que se pidió la cita
DF$ScheduledHour <- paste0(substr(DF$ScheduledDay,11,13), " h")

# Modificamos la columna del dia que se pidió la cita, de forma que sea de tipo date y solo la parte del dia, no el datestamp
DF$ScheduledDay <- as.Date(substr(DF$ScheduledDay,1,10))

# Finalmente modificamos la columna del dia de la cita, de forma que sea de tipo date.
DF$AppointmentDay <- as.Date(DF$AppointmentDay)


# Modificamos los campos de valores 1 y 0 a dimensiones categóricas de 'Yes' y 'No'

DF$Scholarship[DF$Scholarship==1] <- 'Yes'
DF$Scholarship[DF$Scholarship==0] <- 'No'

DF$Hipertension[DF$Hipertension==1] <- 'Yes'
DF$Hipertension[DF$Hipertension==0] <- 'No'

DF$Diabetes[DF$Diabetes==1] <- 'Yes'
DF$Diabetes[DF$Diabetes==0] <- 'No'

DF$Alcoholism[DF$Alcoholism==1] <- 'Yes'
DF$Alcoholism[DF$Alcoholism==0] <- 'No'

DF$Handcap[DF$Handcap==1] <- 'Yes'
DF$Handcap[DF$Handcap==0] <- 'No'

DF$SMS_received[DF$SMS_received==1] <- 'Yes'
DF$SMS_received[DF$SMS_received==0] <- 'No'

View(DF)
write.csv(DF,"C:/Users/nil.busquets/Dropbox/UOC/UOC 2B/Visualización de datos/PRAC 2/Hospital_Appointments.csv", row.names = FALSE)


# Creamos el Dataframe del calendario de los schduled days, con los siguientes campos: Año, Mes, Día, Día de la setmana
DFSchedule <- select(DF, ScheduledDay)

DFSchedule$Year <- format(DF$ScheduledDay, format = "%Y")
DFSchedule$Month <- format(DF$ScheduledDay, format = "%m")
DFSchedule$Day <- format(DF$ScheduledDay, format = "%d")
DFSchedule$Weekday <- weekdays(as.Date(DF$ScheduledDay))


View(DFSchedule)

write.csv(DFSchedule,"C:/Users/nil.busquets/Dropbox/UOC/UOC 2B/Visualización de datos/PRAC 2/Calendar_Schedule.csv", row.names = FALSE)

# Creamos el Dataframe del calendario de los appointment days, con los siguientes campos: Año, Mes, Día, Día de la setmana
DFAppointment <- select(DF, AppointmentDay)

DFAppointment$Year <- format(DF$AppointmentDay, format = "%Y")
DFAppointment$Month <- format(DF$AppointmentDay, format = "%m")
DFAppointment$Day <- format(DF$AppointmentDay, format = "%d")
DFAppointment$Weekday <- weekdays(as.Date(DF$AppointmentDay))

View(DFAppointment)

write.csv(DFAppointment,"C:/Users/nil.busquets/Dropbox/UOC/UOC 2B/Visualización de datos/PRAC 2/Calendar_Appointment.csv", row.names = FALSE)


