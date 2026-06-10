-- ============================================
-- 小马零食铺 Supabase 数据库设置
-- ============================================
-- 在 Supabase SQL Editor 中运行此脚本
-- 网址: https://supabase.com/dashboard
-- 选你的 Project → SQL Editor → New Query → 粘贴执行

-- 1. 创建订单表
CREATE TABLE IF NOT EXISTS orders (
  id BIGSERIAL PRIMARY KEY,
  items JSONB NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  item_count INTEGER NOT NULL DEFAULT 0,
  status TEXT DEFAULT '已下单',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 开启行级安全
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- 3. 允许所有人读写（家庭零食店，风险低）
--    如需限制，可改为需要登录的 policy
CREATE POLICY "允许所有人访问"
  ON orders
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- 4. (可选) 创建索引加速查询
CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);
