# CineBase

[English](README.md) | **简体中文**

一个使用 PostgreSQL 实现的电影目录、评分、影评及用户片单数据库示例，包含 11 张关系表、示例数据和六项业务查询。

作者：**EyjafjallaY**

SQL 最初用于个人课程项目，在本公开版本中保持原样。文档和关系图说明的是现有代码实际实现的内容。

## 阅读入口

以下设计、示例和验证文档目前为英文。

- [数据库结构与设计说明](docs/design.md)
- [关系图](docs/schema.svg)
- [查询示例与结果含义](docs/query_examples.md)
- [验证范围与结果](docs/verification.md)

## 文件说明

| 文件 | 作用 |
| --- | --- |
| [sql/ddl.sql](sql/ddl.sql) | 创建表、键、检查约束、PL/pgSQL 函数和延迟约束触发器；末尾包含 watchlist 表的字段检查查询。 |
| [sql/dml.sql](sql/dml.sql) | 在事务内插入示例数据，展示所有表，并执行两项缺失关联检查。 |
| [sql/dql.sql](sql/dql.sql) | 包含六项业务查询，保留原来的 Q1、Q2、Q3、Q4、Q4b、Q5 编号。 |
| [docs/schema.mmd](docs/schema.mmd) | 描述数据库关系的可编辑 Mermaid 源文件。 |
| [docs/schema.svg](docs/schema.svg) | 根据同一组表和外键关系生成的独立关系图。 |

## 本地运行

需要已有的 PostgreSQL 服务、createdb 和 psql 客户端工具，以及有权限创建数据库和数据库对象的角色。下文 SQL 验证使用 PostgreSQL 17.9 完成，其他版本尚未测试。

从本仓库根目录执行以下命令。请根据自己的环境调整主机、数据库角色和数据库名称。

~~~sh
createdb --host=localhost --username=postgres --template=template0 --encoding=UTF8 cinebase_demo
psql --host=localhost --username=postgres --dbname=cinebase_demo -X --set=ON_ERROR_STOP=1 --command="SET client_encoding TO 'UTF8';" --file=sql/ddl.sql --file=sql/dml.sql --file=sql/dql.sql
~~~

请使用新建的空数据库。示例插入语句依赖新 SERIAL 序列从 1 开始分配 ID。如果创建数据库时提示名称已被占用，请先换一个名称，再执行 SQL。不要在已有对象或数据的数据库中运行这些脚本。

执行顺序为 ddl.sql、dml.sql、dql.sql。示例数据文件已包含 BEGIN 和 COMMIT，并在同一事务内写入满足延迟参与约束所需的记录。它不是可重复执行的幂等更新脚本：在已有示例数据的数据库中再次运行，可能违反唯一性约束。

示例数据脚本先展示 11 张表，再检查是否存在没有档案的用户、没有类型关联的电影。这两项缺失关联查询均应返回零行。

## 业务查询

| 编号 | 回答的问题 |
| --- | --- |
| Q1 | 每部电影的平均评分和评分次数是多少？包括尚无评分的电影。 |
| Q2 | 每位演员关联了哪些电影？ |
| Q3 | 每位用户的片单中有哪些电影，各自处于什么状态？ |
| Q4 | 每种类型关联了多少部电影？包括尚无电影关联的类型。 |
| Q4b | 哪些电影符合示例中的片名、类型、上映年份和平均评分筛选条件？ |
| Q5 | 示例用户有哪些评分，以及与这些评分匹配的影评？ |

## 示例数据

11 张表共包含 181 条示例记录。用户档案、评分和影评是演示数据，不是真实平台用户数据。片名和电影创作者姓名对应真实电影及公众人物；描述文字用于举例，不构成经过核实的电影数据源。

示例数据文件保留了原来的演示邮箱、用户名、密码占位字符串，以及一条虚构用户档案中的学校字样。项目没有实现邮件发送、登录、密码校验或账户管理应用。password_hash 字段中的值只是占位数据，并非可用于认证的有效密码哈希。

## 验证与限制

三个 SQL 文件已使用 PostgreSQL 17.9，在新建且独立的数据目录中通过离线单用户模式执行。六项业务查询全部完成，181 条示例记录数量正确，16 项额外完整性检查通过。详见[验证说明](docs/verification.md)。

本项目是数据库示例，没有包含网页应用、推荐模型、ETL 管道或生产环境认证。延迟触发器函数会反复扫描相关表，尚未评估并发访问、大规模数据或性能。本次本地 SQL 验证没有测试上面的 psql 客户端连接指令。

## 许可证

本项目使用 [MIT 许可证](LICENSE)。

Copyright (c) 2026 EyjafjallaY.
