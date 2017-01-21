CREATE TABLE IF NOT EXISTS "weibo_status" (
    "statusId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "status" TEXT,
    PRIMARY KEY("statusId", "userId")
);
