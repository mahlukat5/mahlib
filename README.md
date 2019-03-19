# Fonksiyonları istediğiniz bir scriptten kullanmak için aşşağıdaki kodu .lua dosyasının başına yerleştirin.
kod: loadstring(exports["MahLib"].getFunctions())()

Sadece bir kaç fonksiyon kullanmak isterseniz;

loadstring(exports["MahLib"].getFunctions("guiCreateWindow","guiCreateButton"))()

daha fazla bilgi için:http://www.mtasaturk.com/script/(indir)-mahlib/
