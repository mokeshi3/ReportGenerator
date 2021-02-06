#!/bin/perl
use strict;
use warnings;

# テンプレート
my $tmp_name = "ZZZZ"; # 新しいタグの仮の名前
my $template = "$tmp_name\ttex/$tmp_name.tex\t1";

# ファイルの取得と変数宣言
open (F, "<", "./tags") || die "can not found 'ctags'. $!";
my @contents; # tagsに書かれている情報を格納する

# 元々書かれていたtag情報の取得
while(<F>) {
	chomp($_);
	push(@contents, $_);
}

# 引数で渡されたtag情報を追加 & ファイル生成
foreach my $filename (@ARGV) {
	chomp($filename);
	my $newtag = $template;
	$newtag =~ s/$tmp_name/$filename/g;
	push(@contents, $newtag);
	open(TMP, ">", "tex/$filename.tex");
	close(TMP);
}

# ソートしてファイルに書き込む
@contents = sort {$a cmp $b} @contents;
close(F);
open (F, ">", "./tags") || die "can not found 'ctags'. $!";

foreach my $i (@contents){
	print F $i, "\n";
}
