@echo off
cd /d C:\pleiades\workspace\C4
java -cp "build\classes;src\main\webapp\WEB-INF\lib/*" batch.MedicationMailBatch
