# bisonとflexを用いたコンパイラの作成練習

## 実行プログラム作成の手順
1. 構文解析プログラムファイルの生成  
express.yファイルから`express.tab.c`と`express.tab.h`を作成する。  
```bison -y express.y```
2. 構文解析プログラムファイル(`express.tab.c`)から実行プログラムの生成  
```gcc y.tab.c -ly -o express```
3. 実行
```./express```

## 構文解析ファイル`.y`の文法規則
```
%{
C の宣言文
%}

Bison の宣言文

%%
文法規則
%%

ユーザー・コード
```

## 字句解析ファイル`.l`の文法規則
```
C の宣言文

%%
字句解析の規則
%%

ユーザー・コード
```