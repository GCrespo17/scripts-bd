  Create user U_RES 
  identified BY 1234;
  Grant create session to U_RES;
  Grant RESTAURADOR to U_RES;
  
  Create user U_CUR 
  identified BY 1234;
  Grant create session to U_CUR;
  Grant CURADOR to U_CUR;
  
  Create user U_MAN 
  identified BY 1234;
  Grant create session to U_MAN;
  Grant MANTENIMIENTO to U_MAN;
  
  Create user U_DIR 
  identified BY 1234;
  Grant create session to U_DIR;
  Grant DIRECTOR to U_DIR;
  
  Create user U_RRHH 
  identified BY 1234;
  Grant create session to U_RRHH;
  Grant RRHH to U_RRHH;
  