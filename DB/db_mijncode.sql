SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `db_mijncode` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `db_mijncode` ;

-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_planes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_planes` (
  `id_planes` INT NOT NULL AUTO_INCREMENT ,
  `nombre_plan` VARCHAR(45) NOT NULL ,
  `monto` DOUBLE NOT NULL ,
  PRIMARY KEY (`id_planes`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellido` VARCHAR(45) NOT NULL ,
  `correo` VARCHAR(45) NOT NULL ,
  `nombre_usuario` VARCHAR(45) NOT NULL ,
  `contrasena` VARCHAR(45) NOT NULL ,
  `imagen_perfil` VARCHAR(400) NOT NULL ,
  `id_planes` INT NOT NULL ,
  PRIMARY KEY (`id_usuarios`) ,
  INDEX `fk_tbl_usuarios_tbl_planes` (`id_planes` ASC) ,
  CONSTRAINT `fk_tbl_usuarios_tbl_planes`
    FOREIGN KEY (`id_planes` )
    REFERENCES `db_mijncode`.`tbl_planes` (`id_planes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_lenguajes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_lenguajes` (
  `id_lenguajes` INT NOT NULL AUTO_INCREMENT ,
  `lenguaje` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_lenguajes`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_carpetas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_carpetas` (
  `id_carpetas` INT NOT NULL AUTO_INCREMENT ,
  `nombre_carpeta` VARCHAR(45) NOT NULL ,
  `id_usuarios` INT NOT NULL ,
  PRIMARY KEY (`id_carpetas`) ,
  INDEX `fk_tbl_carpetas_tbl_usuarios1` (`id_usuarios` ASC) ,
  CONSTRAINT `fk_tbl_carpetas_tbl_usuarios1`
    FOREIGN KEY (`id_usuarios` )
    REFERENCES `db_mijncode`.`tbl_usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_archivos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_archivos` (
  `id_archivos` INT NOT NULL AUTO_INCREMENT ,
  `nombre_archivo` VARCHAR(45) NOT NULL ,
  `id_lenguajes` INT NOT NULL ,
  `id_carpetas` INT NOT NULL ,
  `id_usuarios` INT NOT NULL ,
  PRIMARY KEY (`id_archivos`) ,
  INDEX `fk_tbl_archivos_tbl_lenguajes1` (`id_lenguajes` ASC) ,
  INDEX `fk_tbl_archivos_tbl_carpetas1` (`id_carpetas` ASC) ,
  INDEX `fk_tbl_archivos_tbl_usuarios1` (`id_usuarios` ASC) ,
  CONSTRAINT `fk_tbl_archivos_tbl_lenguajes1`
    FOREIGN KEY (`id_lenguajes` )
    REFERENCES `db_mijncode`.`tbl_lenguajes` (`id_lenguajes` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_archivos_tbl_carpetas1`
    FOREIGN KEY (`id_carpetas` )
    REFERENCES `db_mijncode`.`tbl_carpetas` (`id_carpetas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_archivos_tbl_usuarios1`
    FOREIGN KEY (`id_usuarios` )
    REFERENCES `db_mijncode`.`tbl_usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_snippets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_snippets` (
  `id_snippets` INT NOT NULL AUTO_INCREMENT ,
  `nombre_snippet` VARCHAR(500) NOT NULL ,
  PRIMARY KEY (`id_snippets`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_snippets_carpetas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_snippets_carpetas` (
  `id_snippets` INT NOT NULL ,
  `id_carpetas` INT NOT NULL ,
  INDEX `fk_tbl_snippets_has_tbl_carpetas_tbl_carpetas1` (`id_carpetas` ASC) ,
  INDEX `fk_tbl_snippets_has_tbl_carpetas_tbl_snippets1` (`id_snippets` ASC) ,
  CONSTRAINT `fk_tbl_snippets_has_tbl_carpetas_tbl_snippets1`
    FOREIGN KEY (`id_snippets` )
    REFERENCES `db_mijncode`.`tbl_snippets` (`id_snippets` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_snippets_has_tbl_carpetas_tbl_carpetas1`
    FOREIGN KEY (`id_carpetas` )
    REFERENCES `db_mijncode`.`tbl_carpetas` (`id_carpetas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_compartir_carpeta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_compartir_carpeta` (
  `id_carpetas` INT NOT NULL ,
  `id_usuarios` INT NOT NULL ,
  INDEX `fk_tbl_carpetas_has_tbl_usuarios_tbl_usuarios1` (`id_usuarios` ASC) ,
  INDEX `fk_tbl_carpetas_has_tbl_usuarios_tbl_carpetas1` (`id_carpetas` ASC) ,
  CONSTRAINT `fk_tbl_carpetas_has_tbl_usuarios_tbl_carpetas1`
    FOREIGN KEY (`id_carpetas` )
    REFERENCES `db_mijncode`.`tbl_carpetas` (`id_carpetas` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_carpetas_has_tbl_usuarios_tbl_usuarios1`
    FOREIGN KEY (`id_usuarios` )
    REFERENCES `db_mijncode`.`tbl_usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_compartir_archivos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_compartir_archivos` (
  `id_archivos` INT NOT NULL ,
  `id_usuarios` INT NOT NULL ,
  INDEX `fk_tbl_archivos_has_tbl_usuarios_tbl_usuarios1` (`id_usuarios` ASC) ,
  INDEX `fk_tbl_archivos_has_tbl_usuarios_tbl_archivos1` (`id_archivos` ASC) ,
  CONSTRAINT `fk_tbl_archivos_has_tbl_usuarios_tbl_archivos1`
    FOREIGN KEY (`id_archivos` )
    REFERENCES `db_mijncode`.`tbl_archivos` (`id_archivos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_archivos_has_tbl_usuarios_tbl_usuarios1`
    FOREIGN KEY (`id_usuarios` )
    REFERENCES `db_mijncode`.`tbl_usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_proyectos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_proyectos` (
  `id_proyectos` INT NOT NULL AUTO_INCREMENT ,
  `nombre_proyecto` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_proyectos`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_compartir_proyectos`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_compartir_proyectos` (
  `id_usuarios` INT NOT NULL ,
  `id_proyectos` INT NOT NULL ,
  INDEX `fk_tbl_usuarios_has_tbl_proyectos_tbl_proyectos1` (`id_proyectos` ASC) ,
  INDEX `fk_tbl_usuarios_has_tbl_proyectos_tbl_usuarios1` (`id_usuarios` ASC) ,
  CONSTRAINT `fk_tbl_usuarios_has_tbl_proyectos_tbl_usuarios1`
    FOREIGN KEY (`id_usuarios` )
    REFERENCES `db_mijncode`.`tbl_usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_usuarios_has_tbl_proyectos_tbl_proyectos1`
    FOREIGN KEY (`id_proyectos` )
    REFERENCES `db_mijncode`.`tbl_proyectos` (`id_proyectos` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_mijncode`.`tbl_grupo_trabajo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `db_mijncode`.`tbl_grupo_trabajo` (
  `id_grupo_trabajo` INT NOT NULL AUTO_INCREMENT ,
  `nombre_grupo` VARCHAR(45) NOT NULL ,
  `id_usuarios` INT NOT NULL ,
  PRIMARY KEY (`id_grupo_trabajo`) ,
  INDEX `fk_tbl_grupo_trabajo_tbl_usuarios1` (`id_usuarios` ASC) ,
  CONSTRAINT `fk_tbl_grupo_trabajo_tbl_usuarios1`
    FOREIGN KEY (`id_usuarios` )
    REFERENCES `db_mijncode`.`tbl_usuarios` (`id_usuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
