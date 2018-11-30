
INSERT INTO `sys_menu` VALUES ('1', '0', '0,', '顶级菜单', 'top.menu', null, null, null, '0', '1', null, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', null, '0')
INSERT INTO `sys_menu` VALUES ('10', '3', '0,1,2,3,', '字典管理', 'dict.manager', '/sys/dict/', null, 'th-list', '60', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '10', '0,1,2,3,10,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:dict:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '10', '0,1,2,3,10,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:dict:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '2', '0,1,2,', '用户管理', 'group.user', '', '', '', '970', '1', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '13', '0,1,2,13,', '区域管理', 'area.manager', '/sys/area/', '', 'th', '50', '0', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('15', '14', '0,1,2,13,14,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:area:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('16', '14', '0,1,2,13,14,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:area:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('17', '13', '0,1,2,13,', '机构管理', 'office.manager', '/sys/office/', '', 'th-large', '40', '0', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('18', '17', '0,1,2,13,17,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:office:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('19', '17', '0,1,2,13,17,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:office:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '1');
INSERT INTO `sys_menu` VALUES ('2', '1', '0,1,', '系统设置', 'system.setup', '', '', '', '9000', '1', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '13', '0,1,2,13,', '用户管理', 'user.manager', '/sys/user/', null, 'user', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '20', '0,1,2,13,20,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:user:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '20', '0,1,2,13,20,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:user:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '0,1,', '我的面板', 'my.dashboard', '', '', '', '100', '0', '', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:20', null, '0');
INSERT INTO `sys_menu` VALUES ('28', '27', '0,1,27,', '个人信息', 'person.info', null, null, null, '990', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:20', null, '0');
INSERT INTO `sys_menu` VALUES ('29', '28', '0,1,27,28,', '个人信息', 'person.info', '/sys/user/info', null, 'user', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:20', null, '0');
INSERT INTO `sys_menu` VALUES ('3', '2', '0,1,2,', '系统设置', 'system.manager', null, null, null, '980', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('30', '28', '0,1,27,28,', '修改密码', 'modify.password', '/sys/user/modifyPwd', null, 'lock', '40', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:20', null, '0');
INSERT INTO `sys_menu` VALUES ('4', '3', '0,1,2,3,', '菜单管理', 'menu.manager', '/sys/menu/', null, 'list-alt', '30', '1', null, '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', nul
INSERT INTO `sys_menu` VALUES ('6', '4', '0,1,2,3,4,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:menu:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('5', '4', '0,1,2,3,4,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:menu:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '7', '0,1,2,3,7,', '查看', 'operation.view', null, null, null, '30', '0', 'sys:role:view', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:27', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '7', '0,1,2,3,7,', '修改', 'operation.modify', null, null, null, '30', '0', 'sys:role:edit', '1', '2013-05-27 08:00:00', '1', '2015-02-06 17:00:28', null, '0');