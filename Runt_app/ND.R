date<-"2012-01-02"
ND<- function(date){
  nuevos_datos<- data.frame("Fecha" = as.Date(date,format= "%Y-%m-%d"))
  nuevos_datos$year<-as.integer(format(nuevos_datos$Fecha,"%Y"))
  nuevos_datos$mes<-as.factor(months(nuevos_datos$Fecha))
  nuevos_datos$dia<-as.factor(weekdays(nuevos_datos$Fecha))
  nuevos_datos$dia_num <- as.integer(format(nuevos_datos$Fecha,"%d"))
  nuevos_datos$holi_bin <- ifelse(nuevos_datos$Fecha %in% holid$date,1,
                                ifelse(nuevos_datos$dia == "Sunday",1, 0)) %>% factor()
  #Fechas especiales
  nuevos_datos <- left_join(x = nuevos_datos, y = observance[,c("date","name")], 
                          by=c("Fecha" = "date"))
  nuevos_datos$name<-as.character(nuevos_datos$name)
  nuevos_datos <- nuevos_datos %>% mutate("name" = if_else(is.na(nuevos_datos$name), "Ninguno", nuevos_datos$name))
  nuevos_datos<-fastDummies::dummy_cols(nuevos_datos, select_columns = "name", remove_first_dummy = T)
  nuevos_datos<- nuevos_datos[,!names(nuevos_datos) %in% c("name","name_Ninguno")]#quitar columna name y name_ninguno
  nuevos_datos[6:29] <- lapply(nuevos_datos[6:29] , factor) 
  return(nuevos_datos)
}