CREATE TABLE IF NOT EXISTS "weibo_status" (
    "statusId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "status" TEXT,
    "createTime" TEXT DEFAULT (datetime('now', 'localtime')),
    PRIMARY KEY("statusId", "userId")
);
