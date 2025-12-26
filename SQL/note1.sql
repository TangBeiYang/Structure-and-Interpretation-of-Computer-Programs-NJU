-- ============================================
-- SQL I 课程总结 (Berkeley CS61A)
-- ============================================
-- 注：本文件使用SQLite语法，可在 https://sql.cs61a.org 在线运行

-- ============================================
-- 1. 声明式编程 vs 命令式编程
-- ============================================
/*声明式编程 vs 命令式编程：

命令式编程(C,python,scheme) (Imperative):
- 告诉计算机"如何"完成任务
- 包含明确的执行指令
- 示例：遍历数组、条件判断、循环等

声明式编程(SQL) (Declarative):
- 告诉计算机"想要什么"
- 由系统决定如何实现
- 示例：SQL查询、函数式编程

类比：
命令式：详细描述找桌子的每一步
声明式：只说"两人桌"   */

-- ============================================
-- 2. SQL基础：创建表和基本查询
-- ============================================

-- 2.1 创建表：使用CREATE TABLE和SELECT UNION
CREATE TABLE cities AS                                                   --CREATE TABLE只是命名
SELECT 38 AS latitude, 122 AS longitude, "Berkeley" AS name UNION        --SELECT UNION才是创建
SELECT 42,              71,              "Cambridge"         UNION
SELECT 45,              93,              "Minneapolis";--末尾;不能忘
/*cities表结构：
| latitude | longitude | name        |
|----------|-----------|-------------|
| 38       | 122       | Berkeley    |
| 42       | 71        | Cambridge   |
| 45       | 93        | Minneapolis | */

-- 2.2 基本SELECT查询：创建新表（临时表）
SELECT "west coast" AS region, name FROM cities WHERE longitude >= 115 UNION
SELECT "other", name FROM cities WHERE longitude < 115;

/*结果：
| region    | name        |
|-----------|-------------|
| west coast| Berkeley    |
| other     | Cambridge   |
| other     | Minneapolis | */

-- ============================================
-- 3. 选择字面量和命名表
-- ============================================

-- 3.1 选择字面量创建单行表
SELECT "delano" AS parent, "herbert" AS child UNION
SELECT "abraham", "barack" UNION
SELECT "abraham", "clinton" UNION
SELECT "fillmore", "abraham" UNION
SELECT "fillmore", "delano" UNION
SELECT "fillmore", "grover" UNION
SELECT "eisenhower", "fillmore";

-- 3.2 创建命名表（永久存储）
CREATE TABLE parents AS
SELECT "delano" AS parent, "herbert" AS child UNION
SELECT "abraham", "barack" UNION
SELECT "abraham", "clinton" UNION
SELECT "fillmore", "abraham" UNION
SELECT "fillmore", "delano" UNION
SELECT "fillmore", "grover" UNION
SELECT "eisenhower", "fillmore";

/*parents表：
| parent     | child     |
|------------|-----------|
| delano     | herbert   |
| abraham    | barack    |
| abraham    | clinton   |
| fillmore   | abraham   |
| fillmore   | delano    |
| fillmore   | grover    |
| eisenhower | fillmore  | */

-- ============================================
-- 4. SELECT语句详解
-- ============================================
/*
SELECT语句完整语法：
SELECT [columns] FROM [table] WHERE [condition] ORDER BY [order] [ASC(升序)/DESC(降序)] LIMIT [number]; */
-- 没有group操作

-- 4.1 从现有表中选择
-- 选择所有列
SELECT * FROM parents;

-- 按条件选择特定列
SELECT child FROM parents WHERE parent = "abraham";

-- 使用比较运算符
SELECT parent FROM parents WHERE parent <> child;

-- 4.2 排序结果
-- 按parent降序排列
SELECT * FROM parents ORDER BY parent DESC;

-- 4.3 使用LIMIT限制结果数量
SELECT * FROM parents ORDER BY parent LIMIT 3;

-- ============================================
-- 5. SELECT中的算术运算
-- ============================================

-- 5.1 创建餐厅座位表
CREATE TABLE restaurant AS
SELECT 101 AS table_num, 2 AS single, 2 AS couple UNION
SELECT 102,             0,           3            UNION
SELECT 103,             3,           1;

-- 5.2 使用算术表达式计算总人数
SELECT 
    table_num, 
    single + 2 * couple AS total 
FROM restaurant;

/*结果：
| table_num | total |
|-----------|-------|
| 101       | 6     |
| 102       | 6     |
| 103       | 5     | */

-- ============================================
-- 6. 练习题：数字表示系统
-- ============================================

-- 创建整数二进制表示表
CREATE TABLE ints AS
SELECT "zero"  AS word, 0 AS one, 0 AS two, 0 AS four, 0 AS eight UNION
SELECT "one",           1,        0,        0,        0          UNION
SELECT "two",           0,        2,        0,        0          UNION
SELECT "three",         1,        2,        0,        0          UNION
SELECT "four",          0,        0,        4,        0          UNION
SELECT "five",          1,        0,        4,        0          UNION
SELECT "six",           0,        2,        4,        0          UNION
SELECT "seven",         1,        2,        4,        0          UNION
SELECT "eight",         0,        0,        0,        8          UNION
SELECT "nine",          1,        0,        0,        8;

-- (A) 创建两列表：单词和对应的整数值
SELECT 
    word, 
    one + two + four + eight AS value 
FROM ints;

-- (B) 选择2的幂次方的单词名称
SELECT word FROM ints 
WHERE one + two + four + eight IN (1, 2, 4, 8);--WHERE one + two/2 +four/4 + eight/8 = 1

-- ============================================
-- 7. 表连接（JOIN）
-- ============================================

-- 7.1 创建狗狗毛发类型表
CREATE TABLE dogs AS
SELECT "abraham"    AS name, "long"   AS fur UNION
SELECT "barack",             "short"         UNION
SELECT "clinton",            "long"          UNION
SELECT "delano",             "long"          UNION
SELECT "eisenhower",         "short"         UNION
SELECT "fillmore",           "curly"         UNION
SELECT "grover",             "short"         UNION
SELECT "herbert",            "curly";

-- 7.2 查找卷毛狗狗的父母
-- 方法1：使用逗号连接（隐式连接）
SELECT DISTINCT parent 
FROM parents, dogs 
WHERE child = name AND fur = "curly";

-- 方法2：使用显式JOIN语法（SQL标准）
SELECT DISTINCT parent 
FROM parents 
JOIN dogs ON child = name 
WHERE fur = "curly";

/*结果：
| parent     |
|------------|
| delano     |
| eisenhower | */

-- 7.3 表自连接：查找所有兄弟/姐妹对
-- 为同一表创建别名以避免列名冲突(不同表有同样的列时也要创建别名)
SELECT 
    a.child AS first, 
    b.child AS second
FROM parents AS a, parents AS b
WHERE a.parent = b.parent      -- 同一个父母
  AND a.child < b.child;       -- 避免重复对和自配对

/*结果：
| first   | second  |
|---------|---------|
| barack  | clinton |
| abraham | delano  |
| abraham | grover  |
| delano  | grover  | */

-- ============================================
-- 8. 字符串表达式
-- ============================================

-- 8.1 字符串连接操作符 ||
SELECT "hello," || " world";  -- 结果: "hello, world"

-- 8.2 在查询中使用字符串连接
SELECT name || " dog" AS description FROM dogs;

/*
结果：
| description    |
|----------------|
| abraham dog    |
| barack dog     |
| clinton dog    |
| delano dog     |
| eisenhower dog |
| fillmore dog   |
| grover dog     |
| herbert dog    |
*/

-- 8.3 更复杂的字符串操作
SELECT 
    name || " has " || fur || " fur" AS dog_description
FROM dogs
ORDER BY name;

-- ============================================
-- 9. 高级查询技巧
-- ============================================

-- 9.1 使用子查询
-- 查找所有有孩子的父母（去重）
SELECT DISTINCT parent 
FROM parents 
WHERE parent IN (SELECT parent FROM parents WHERE child IS NOT NULL);

-- 9.2 聚合函数示例
-- 计算每个父母的子女数量
SELECT 
    parent, 
    COUNT(*) AS child_count
FROM parents 
GROUP BY parent 
ORDER BY child_count DESC;

-- 9.3 条件表达式
-- 使用CASE语句对毛发类型分类
SELECT 
    name,
    fur,
    CASE 
        WHEN fur = 'curly' THEN 'special'
        WHEN fur = 'long' THEN 'long-haired'
        ELSE 'short-haired'
    END AS fur_category
FROM dogs;

-- ============================================
-- 10. 综合练习
-- ============================================

-- 10.1 查找所有短毛狗狗的父母
SELECT DISTINCT p.parent
FROM parents p
JOIN dogs d ON p.child = d.name
WHERE d.fur = 'short';

-- 10.2 查找没有出现在child列中的名字（可能是"祖父母"）
SELECT DISTINCT parent
FROM parents
WHERE parent NOT IN (SELECT child FROM parents WHERE child IS NOT NULL);

-- 10.3 创建完整的家谱视图
CREATE VIEW family_tree AS
SELECT 
    p.parent AS ancestor,
    p.child AS descendant,
    1 AS generation
FROM parents p
UNION ALL
SELECT 
    gp.parent AS ancestor,
    p.child AS descendant,
    2 AS generation
FROM parents gp
JOIN parents p ON gp.child = p.parent;

-- 查看家谱
SELECT * FROM family_tree ORDER BY ancestor, generation;

-- ============================================
-- 13 练习题：音乐数据库查询
-- ============================================

/*假设有以下三个表：
歌曲表 (songs):
| name | artist | album |
专辑表 (albums):
| name | artist | release_year |
艺术家表 (artists):
| name | first_year_active | */

-- 创建示例数据
CREATE TABLE songs AS
SELECT "Blinding Lights" AS name, "The Weeknd" AS artist, "After Hours" AS album UNION
SELECT "Shape of You", "Ed Sheeran", "÷" UNION
SELECT "Bad Guy", "Billie Eilish", "When We All Fall Asleep, Where Do We Go?" UNION
SELECT "Uptown Funk", "Mark Ronson ft. Bruno Mars", "Uptown Special" UNION
SELECT "Rolling in the Deep", "Adele", "21" UNION
SELECT "Old Town Road", "Lil Nas X", "7" UNION
SELECT "Levitating", "Dua Lipa", "Future Nostalgia";

CREATE TABLE albums AS
SELECT "After Hours" AS name, "The Weeknd" AS artist, 2020 AS release_year UNION
SELECT "÷", "Ed Sheeran", 2017 UNION
SELECT "When We All Fall Asleep, Where Do We Go?", "Billie Eilish", 2019 UNION
SELECT "Uptown Special", "Mark Ronson ft. Bruno Mars", 2015 UNION
SELECT "21", "Adele", 2011 UNION
SELECT "7", "Lil Nas X", 2019 UNION
SELECT "Future Nostalgia", "Dua Lipa", 2020;

CREATE TABLE artists AS
SELECT "The Weeknd" AS name, 2010 AS first_year_active UNION
SELECT "Ed Sheeran", 2005 UNION
SELECT "Billie Eilish", 2015 UNION
SELECT "Mark Ronson ft. Bruno Mars", 2003 UNION
SELECT "Adele", 2006 UNION
SELECT "Lil Nas X", 2018 UNION
SELECT "Dua Lipa", 2015;

-- 查看表结构
-- SELECT * FROM songs;
-- SELECT * FROM albums;
-- SELECT * FROM artists;

-- ============================================
-- 练习题1：输出2015年后开始活跃的前10位艺术家
-- ============================================

SELECT name FROM artists 
WHERE first_year_active > 2015 
LIMIT 10;

/*预期结果（示例数据中）：
| name        |
|-------------|
| Lil Nas X   | */

-- ============================================
-- 练习题2：输出2019年发布的歌曲名称和艺术家，
-- 并按艺术家的首次活跃年份排序
-- ============================================

-- 方法1：使用逗号连接（隐式连接）
SELECT s.name AS song_name, s.artist
FROM songs AS s, artists AS ar, albums AS al
WHERE s.album = al.name 
  AND s.artist = ar.name
  AND al.release_year = 2019
ORDER BY ar.first_year_active;

-- 方法2：使用显式JOIN语法（更清晰）
SELECT s.name AS song_name, s.artist
FROM songs s
JOIN albums al ON s.album = al.name
JOIN artists ar ON s.artist = ar.name
WHERE al.release_year = 2019
ORDER BY ar.first_year_active;

/*预期结果：
| song_name           | artist          | release_year |
|---------------------|-----------------|--------------|
| Bad Guy             | Billie Eilish   | 2019         |
| Old Town Road       | Lil Nas X       | 2019         | */

-- ============================================
-- 额外练习：复杂JOIN查询
-- ============================================

-- 练习3：找出每个艺术家的最新专辑
SELECT 
    ar.name AS artist,
    al.name AS latest_album,
    al.release_year
FROM artists ar
JOIN albums al ON ar.name = al.artist
WHERE al.release_year = (
    SELECT MAX(release_year) 
    FROM albums 
    WHERE artist = ar.name
);

-- 练习4：统计每位艺术家的歌曲数量
SELECT 
    ar.name AS artist,
    COUNT(s.name) AS song_count
FROM artists ar
LEFT JOIN songs s ON ar.name = s.artist
GROUP BY ar.name
ORDER BY song_count DESC;

-- 练习5：查找拥有多张专辑的艺术家
SELECT 
    artist,
    COUNT(*) AS album_count
FROM albums
GROUP BY artist
HAVING COUNT(*) > 1;
