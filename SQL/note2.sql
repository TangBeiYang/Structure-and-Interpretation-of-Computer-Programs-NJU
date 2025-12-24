-- ============================================
-- SQL II 课程总结 - 聚合操作与表操作
-- ============================================

-- ============================================
-- 1. 聚合函数(Aggregation Functions)
-- ============================================

/*聚合函数用于对多行数据进行计算，返回单个值
常用聚合函数：
- MAX(column): 返回最大值
- MIN(column): 返回最小值
- AVG(column): 返回平均值
- COUNT(column): 返回行数
- SUM(column): 返回总和  */

-- 1.1 基本聚合查询
-- 计算所有狗的平均年龄
SELECT AVG(age) AS avg_age FROM dogs;
-- 结果：avg_age = (9+4+8+10+3)/5 = 6.8

-- 计算狗的总数
SELECT COUNT(*) AS total_count FROM dogs;
-- 结果：total_count = 5

-- 计算年龄总和
SELECT SUM(age) AS total_age FROM dogs;
-- 结果：total_age = 34

-- 找到最小的名字（按字母顺序）
SELECT MIN(name) AS first_name FROM dogs;
-- 结果：first_name = 'abraham'

-- ============================================
-- 2. 分组操作(GROUP BY)
-- ============================================
/*
GROUP BY 子句用于将行分组，然后对每个组应用聚合函数
语法：
SELECT column1, aggregate_function(column2)
FROM table
GROUP BY column1; */

-- 2.1 按毛发类型分组计算平均年龄
SELECT fur, AVG(age) AS avg_age
FROM dogs
GROUP BY fur;

-- 结果：
-- | fur   | avg_age |
-- |-------|---------|
-- | long  | 9.5     |  -- (9+10)/2
-- | curly | 6       |  -- (4+8)/2
-- | short | 3       |  -- 3/1

-- 2.2 按表达式分组
-- 按年龄奇偶性分组计数
SELECT 
    CASE 
        WHEN age % 2 = 0 THEN 'even' 
        ELSE 'odd' 
    END AS age_type,
    COUNT(*) AS count
FROM dogs
GROUP BY age % 2;

-- 结果：
-- | age_type | count |
-- |----------|-------|
-- | odd      | 3     |  -- 9, 3, 5? 示例数据中只有2个奇数
-- | even     | 2     |  -- 4, 8, 10

-- 2.3 多列分组
-- 先创建有更多数据的表
CREATE TABLE dogs_ext AS
SELECT 'abraham' AS name, 'long' AS fur, 9 AS age, 'M' AS gender UNION
SELECT 'herbert', 'curly', 4, 'M' UNION
SELECT 'fillmore', 'curly', 8, 'F' UNION
SELECT 'delano', 'long', 10, 'M' UNION
SELECT 'eisenhower', 'short', 3, 'F' UNION
SELECT 'grover', 'short', 5, 'M';

-- 按毛发类型和性别分组计算平均年龄
SELECT fur, gender, AVG(age) AS avg_age
FROM dogs_ext
GROUP BY fur, gender;

-- ============================================
-- 3. 分组过滤(HAVING)
-- ============================================

--HAVING 与 WHERE 区别:
/*特性	            WHERE	                 HAVING
执行时机	            分组前，数据过滤	       分组后，组过滤
操作对象	            原始表的行	             分组后的组(会删除整个组)
能否使用聚合函数     ❌ 不能直接使用	       ✅ 可以使用
与 GROUP BY 的关系	  可选，不依赖	必须与      GROUP BY 一起使用
性能影响	            先过滤，减少分组数据量	 后过滤，对分组结果过滤  */

-- 3.1 基本HAVING使用
-- 查找有多个狗的毛发类型的平均年龄
SELECT fur, AVG(age) AS avg_age
FROM dogs
GROUP BY fur
HAVING COUNT(*) > 1;

-- 结果（过滤掉只有1只狗的毛发类型）：
-- | fur   | avg_age |
-- |-------|---------|
-- | long  | 9.5     |
-- | curly | 6       |

-- 3.2 复杂HAVING条件
-- 查找父母的子女平均年龄，且最小子女年龄至少5岁
SELECT p.parent, AVG(d.age) AS avg_child_age
FROM dogs d, parents p
WHERE d.name = p.child
GROUP BY p.parent
HAVING MIN(d.age) >= 5;

-- 分析：先连接表，按父母分组，计算平均年龄
-- HAVING条件：该父母的最小子女年龄≥5

-- 示例数据结果：
-- | parent     | avg_child_age |
-- |------------|---------------|
-- | fillmore   | 9.5           |  -- (abraham:9 + delano:10)/2
-- | eisenhower | 8             |  -- fillmore:8

-- ============================================
-- 4. 表操作：创建、修改、删除
-- ============================================

-- 4.1 创建空表
-- 创建只有列定义的空表
CREATE TABLE empty_dogs(name TEXT, fur TEXT, age INTEGER);

-- 创建带默认值的表
CREATE TABLE dogs_with_default(
    name TEXT, 
    fur TEXT, 
    phrase TEXT DEFAULT 'woof'--  默认值
);

-- 4.2 插入数据
-- 插入指定列的值（其他列使用默认值）
INSERT INTO dogs_with_default(name, fur) 
VALUES('fillmore', 'curly');

-- 插入所有列的值
INSERT INTO dogs_with_default 
VALUES('delano', 'long', 'hi!');

-- 批量插入
INSERT INTO dogs_with_default(name, fur, phrase)
VALUES('grover', 'short', 'bark'),         --这里用逗号
      ('herbert', 'curly', 'ruff');

-- 4.3 更新数据
-- 更新符合条件的行
UPDATE dogs_with_default 
SET phrase = 'WOOF' 
WHERE fur = 'curly';

-- 更新所有行
UPDATE dogs_with_default 
SET phrase = UPPER(phrase);

-- 4.4 删除数据
-- 删除符合条件的行
DELETE FROM dogs_with_default 
WHERE fur = 'curly' AND phrase = 'WOOF';

-- 删除所有行（清空表）
DELETE FROM dogs_with_default;

-- 4.5 删除表
-- 删除表（如果存在）
DROP TABLE IF EXISTS dogs_with_default;

-- 强制删除表
DROP TABLE empty_dogs;

-- ============================================
-- 5. 完整查询语句结构
-- ============================================

/*完整SQL查询语句结构：
SELECT [columns]
FROM [tables]
WHERE [condition]        -- 行级过滤
GROUP BY [expression]    -- 分组
HAVING [condition]       -- 组级过滤
ORDER BY [columns][ASC/DESC]       -- 排序
LIMIT [number];          -- 限制行数  */

-- 5.1 完整示例：复杂查询
SELECT 
    d.fur,
    COUNT(*) AS dog_count,
    AVG(d.age) AS avg_age,
    MAX(d.age) AS max_age
FROM dogs d
JOIN parents p ON d.name = p.child
WHERE d.age > 3  -- 行级过滤：只考虑年龄>3的狗
GROUP BY d.fur   -- 按毛发类型分组
HAVING COUNT(*) >= 1  -- 组级过滤：至少1只狗
ORDER BY avg_age DESC  -- 按平均年龄降序
LIMIT 10;  -- 限制结果数量

-- ============================================
-- 6. 总结
-- ============================================

/*本章核心概念：

1. 聚合函数：
   - 用于对多行数据进行计算
   - 常用函数：MAX, MIN, AVG, COUNT, SUM

2. 分组操作：
   - GROUP BY：按指定列或表达式分组
   - HAVING：对分组结果进行过滤
   - 与WHERE的区别：WHERE过滤行，HAVING过滤组

3. 表操作：
   - CREATE TABLE：创建表（带或不带默认值）
   - INSERT INTO：插入新行
   - UPDATE：更新现有行
   - DELETE：删除行
   - DROP TABLE：删除表

4. 查询执行顺序：
   1. FROM + JOIN（获取数据）
   2. WHERE（行过滤）
   3. GROUP BY（分组）
   4. HAVING（组过滤）
   5. SELECT（选择列）
   6. ORDER BY（排序）
   7. LIMIT（限制结果）  */
