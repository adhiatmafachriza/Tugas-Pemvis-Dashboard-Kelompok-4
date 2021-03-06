PGDMP     (    $                x         	   ekspedisi    12.2    12.2 E    Z           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            [           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            \           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ]           1262    17044 	   ekspedisi    DATABASE     �   CREATE DATABASE ekspedisi WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Indonesian_Indonesia.1252' LC_CTYPE = 'Indonesian_Indonesia.1252';
    DROP DATABASE ekspedisi;
                postgres    false            �            1255    17185    hitung_ongkir()    FUNCTION     �  CREATE FUNCTION public.hitung_ongkir() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	tarif INT;
	berat INT;
	harga_layanan INT;
	id_provinsi_asal INT;
	id_kota_asal INT;
	id_provinsi_tujuan INT;
	id_kota_tujuan INT;
BEGIN
	tarif := 0;
	id_kota_tujuan := (
		SELECT kota.id_kota
		FROM paket
		INNER JOIN alamat
		ON paket.id_alamat_tujuan = alamat.id_alamat
		INNER JOIN kota
		ON alamat.id_kota = kota.id_kota
		WHERE paket.id_paket = (SELECT MAX(id_paket) FROM paket)
	);
	id_kota_asal := (
		SELECT kota.id_kota
		FROM paket
		INNER JOIN pelanggan
		ON paket.id_pelanggan = pelanggan.id_pelanggan
		INNER JOIN alamat
		ON pelanggan.id_alamat = alamat.id_alamat
		INNER JOIN kota
		ON alamat.id_kota = kota.id_kota
		WHERE paket.id_paket = (SELECT MAX(id_paket) FROM paket)
	);
	id_provinsi_tujuan := (
		SELECT provinsi.id_provinsi
		FROM paket
		INNER JOIN alamat
		ON paket.id_alamat_tujuan = alamat.id_alamat
		INNER JOIN kota
		ON alamat.id_kota = kota.id_kota
		INNER JOIN provinsi
		ON kota.id_provinsi = provinsi.id_provinsi
		WHERE paket.id_paket = (SELECT MAX(id_paket) FROM paket)
	);
	id_provinsi_asal := (
		SELECT provinsi.id_provinsi
		FROM paket
		INNER JOIN pelanggan
		ON paket.id_pelanggan = pelanggan.id_pelanggan
		INNER JOIN alamat
		ON pelanggan.id_alamat = alamat.id_alamat
		INNER JOIN kota
		ON alamat.id_kota = kota.id_kota
		INNER JOIN provinsi
		ON kota.id_provinsi = provinsi.id_provinsi
		WHERE paket.id_paket = (SELECT MAX(id_paket) FROM paket)
	);
	berat := (
		SELECT SUM(barang.berat)
		FROM barang
		INNER JOIN paket
		ON barang.id_paket = paket.id_paket
		WHERE paket.id_paket = (SELECT MAX(id_paket) FROM paket)
	);
	harga_layanan := (
		SELECT layanan.harga
		FROM layanan
		INNER JOIN paket
		ON paket.id_layanan = layanan.id_layanan
		WHERE paket.id_paket = (SELECT MAX(id_paket) FROM paket)
	);
	
	IF id_provinsi_asal != id_provinsi_tujuan THEN
		tarif := tarif + 10000;
	ELSE
		IF id_kota_asal != id_kota_tujuan THEN
			tarif := tarif + 5000;
		ELSE
			tarif := tarif + 2000;
		END IF;
	END IF;
	
	tarif := tarif + harga_layanan + (1000 * berat);
	
	UPDATE paket SET ongkir = tarif WHERE id_paket = (SELECT MAX(id_paket) FROM paket);
	
	RETURN NEW;
END
$$;
 &   DROP FUNCTION public.hitung_ongkir();
       public          postgres    false            �            1259    17092    alamat    TABLE     �   CREATE TABLE public.alamat (
    id_alamat integer NOT NULL,
    id_kota integer NOT NULL,
    alamat character varying(50) NOT NULL,
    nomor_telepon character varying(15),
    kode_pos character varying(10)
);
    DROP TABLE public.alamat;
       public         heap    postgres    false            �            1259    17090    alamat_id_alamat_seq    SEQUENCE     �   CREATE SEQUENCE public.alamat_id_alamat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.alamat_id_alamat_seq;
       public          postgres    false    207            ^           0    0    alamat_id_alamat_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.alamat_id_alamat_seq OWNED BY public.alamat.id_alamat;
          public          postgres    false    206            �            1259    17144    barang    TABLE     �   CREATE TABLE public.barang (
    id_barang integer NOT NULL,
    id_paket integer NOT NULL,
    deskripsi character varying(50) NOT NULL,
    berat integer NOT NULL
);
    DROP TABLE public.barang;
       public         heap    postgres    false            �            1259    17142    barang_id_barang_seq    SEQUENCE     �   CREATE SEQUENCE public.barang_id_barang_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.barang_id_barang_seq;
       public          postgres    false    215            _           0    0    barang_id_barang_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.barang_id_barang_seq OWNED BY public.barang.id_barang;
          public          postgres    false    214            �            1259    17079    kota    TABLE     �   CREATE TABLE public.kota (
    id_kota integer NOT NULL,
    id_provinsi integer NOT NULL,
    nama_kota character varying(25) NOT NULL
);
    DROP TABLE public.kota;
       public         heap    postgres    false            �            1259    17077    kota_id_kota_seq    SEQUENCE     �   CREATE SEQUENCE public.kota_id_kota_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.kota_id_kota_seq;
       public          postgres    false    205            `           0    0    kota_id_kota_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.kota_id_kota_seq OWNED BY public.kota.id_kota;
          public          postgres    false    204            �            1259    17118    layanan    TABLE     �   CREATE TABLE public.layanan (
    id_layanan integer NOT NULL,
    nama_layanan character varying(10) NOT NULL,
    harga integer NOT NULL
);
    DROP TABLE public.layanan;
       public         heap    postgres    false            �            1259    17116    layanan_id_layanan_seq    SEQUENCE     �   CREATE SEQUENCE public.layanan_id_layanan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.layanan_id_layanan_seq;
       public          postgres    false    211            a           0    0    layanan_id_layanan_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.layanan_id_layanan_seq OWNED BY public.layanan.id_layanan;
          public          postgres    false    210            �            1259    29387 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    postgres    false            �            1259    29385    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          postgres    false    217            b           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          postgres    false    216            �            1259    17126    paket    TABLE     1  CREATE TABLE public.paket (
    id_paket integer NOT NULL,
    id_layanan integer NOT NULL,
    id_alamat_tujuan integer NOT NULL,
    nama_penerima character varying(50) NOT NULL,
    tanggal_pengiriman date NOT NULL,
    tanggal_penerimaan date,
    id_pelanggan integer NOT NULL,
    ongkir integer
);
    DROP TABLE public.paket;
       public         heap    postgres    false            �            1259    17124    paket_id_paket_seq    SEQUENCE     �   CREATE SEQUENCE public.paket_id_paket_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.paket_id_paket_seq;
       public          postgres    false    213            c           0    0    paket_id_paket_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.paket_id_paket_seq OWNED BY public.paket.id_paket;
          public          postgres    false    212            �            1259    17105 	   pelanggan    TABLE     �   CREATE TABLE public.pelanggan (
    id_pelanggan integer NOT NULL,
    id_alamat integer NOT NULL,
    nama_depan character varying(15) NOT NULL,
    nama_belakang character varying(15) NOT NULL
);
    DROP TABLE public.pelanggan;
       public         heap    postgres    false            �            1259    17103    pelanggan_id_pelanggan_seq    SEQUENCE     �   CREATE SEQUENCE public.pelanggan_id_pelanggan_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.pelanggan_id_pelanggan_seq;
       public          postgres    false    209            d           0    0    pelanggan_id_pelanggan_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.pelanggan_id_pelanggan_seq OWNED BY public.pelanggan.id_pelanggan;
          public          postgres    false    208            �            1259    17071    provinsi    TABLE     u   CREATE TABLE public.provinsi (
    id_provinsi integer NOT NULL,
    nama_provinsi character varying(25) NOT NULL
);
    DROP TABLE public.provinsi;
       public         heap    postgres    false            �            1259    17069    provinsi_id_provinsi_seq    SEQUENCE     �   CREATE SEQUENCE public.provinsi_id_provinsi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.provinsi_id_provinsi_seq;
       public          postgres    false    203            e           0    0    provinsi_id_provinsi_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.provinsi_id_provinsi_seq OWNED BY public.provinsi.id_provinsi;
          public          postgres    false    202            �
           2604    17095    alamat id_alamat    DEFAULT     t   ALTER TABLE ONLY public.alamat ALTER COLUMN id_alamat SET DEFAULT nextval('public.alamat_id_alamat_seq'::regclass);
 ?   ALTER TABLE public.alamat ALTER COLUMN id_alamat DROP DEFAULT;
       public          postgres    false    206    207    207            �
           2604    17147    barang id_barang    DEFAULT     t   ALTER TABLE ONLY public.barang ALTER COLUMN id_barang SET DEFAULT nextval('public.barang_id_barang_seq'::regclass);
 ?   ALTER TABLE public.barang ALTER COLUMN id_barang DROP DEFAULT;
       public          postgres    false    215    214    215            �
           2604    17082    kota id_kota    DEFAULT     l   ALTER TABLE ONLY public.kota ALTER COLUMN id_kota SET DEFAULT nextval('public.kota_id_kota_seq'::regclass);
 ;   ALTER TABLE public.kota ALTER COLUMN id_kota DROP DEFAULT;
       public          postgres    false    205    204    205            �
           2604    17121    layanan id_layanan    DEFAULT     x   ALTER TABLE ONLY public.layanan ALTER COLUMN id_layanan SET DEFAULT nextval('public.layanan_id_layanan_seq'::regclass);
 A   ALTER TABLE public.layanan ALTER COLUMN id_layanan DROP DEFAULT;
       public          postgres    false    211    210    211            �
           2604    29390    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            �
           2604    17129    paket id_paket    DEFAULT     p   ALTER TABLE ONLY public.paket ALTER COLUMN id_paket SET DEFAULT nextval('public.paket_id_paket_seq'::regclass);
 =   ALTER TABLE public.paket ALTER COLUMN id_paket DROP DEFAULT;
       public          postgres    false    213    212    213            �
           2604    17108    pelanggan id_pelanggan    DEFAULT     �   ALTER TABLE ONLY public.pelanggan ALTER COLUMN id_pelanggan SET DEFAULT nextval('public.pelanggan_id_pelanggan_seq'::regclass);
 E   ALTER TABLE public.pelanggan ALTER COLUMN id_pelanggan DROP DEFAULT;
       public          postgres    false    208    209    209            �
           2604    17074    provinsi id_provinsi    DEFAULT     |   ALTER TABLE ONLY public.provinsi ALTER COLUMN id_provinsi SET DEFAULT nextval('public.provinsi_id_provinsi_seq'::regclass);
 C   ALTER TABLE public.provinsi ALTER COLUMN id_provinsi DROP DEFAULT;
       public          postgres    false    203    202    203            M          0    17092    alamat 
   TABLE DATA           U   COPY public.alamat (id_alamat, id_kota, alamat, nomor_telepon, kode_pos) FROM stdin;
    public          postgres    false    207   �W       U          0    17144    barang 
   TABLE DATA           G   COPY public.barang (id_barang, id_paket, deskripsi, berat) FROM stdin;
    public          postgres    false    215   SY       K          0    17079    kota 
   TABLE DATA           ?   COPY public.kota (id_kota, id_provinsi, nama_kota) FROM stdin;
    public          postgres    false    205   �Z       Q          0    17118    layanan 
   TABLE DATA           B   COPY public.layanan (id_layanan, nama_layanan, harga) FROM stdin;
    public          postgres    false    211   �]       W          0    29387 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          postgres    false    217   �]       S          0    17126    paket 
   TABLE DATA           �   COPY public.paket (id_paket, id_layanan, id_alamat_tujuan, nama_penerima, tanggal_pengiriman, tanggal_penerimaan, id_pelanggan, ongkir) FROM stdin;
    public          postgres    false    213   ^       O          0    17105 	   pelanggan 
   TABLE DATA           W   COPY public.pelanggan (id_pelanggan, id_alamat, nama_depan, nama_belakang) FROM stdin;
    public          postgres    false    209   �^       I          0    17071    provinsi 
   TABLE DATA           >   COPY public.provinsi (id_provinsi, nama_provinsi) FROM stdin;
    public          postgres    false    203   S_       f           0    0    alamat_id_alamat_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.alamat_id_alamat_seq', 32, true);
          public          postgres    false    206            g           0    0    barang_id_barang_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.barang_id_barang_seq', 27, true);
          public          postgres    false    214            h           0    0    kota_id_kota_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.kota_id_kota_seq', 100, true);
          public          postgres    false    204            i           0    0    layanan_id_layanan_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.layanan_id_layanan_seq', 3, true);
          public          postgres    false    210            j           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 8, true);
          public          postgres    false    216            k           0    0    paket_id_paket_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.paket_id_paket_seq', 22, true);
          public          postgres    false    212            l           0    0    pelanggan_id_pelanggan_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.pelanggan_id_pelanggan_seq', 15, true);
          public          postgres    false    208            m           0    0    provinsi_id_provinsi_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.provinsi_id_provinsi_seq', 3, true);
          public          postgres    false    202            �
           2606    17097    alamat alamat_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.alamat
    ADD CONSTRAINT alamat_pkey PRIMARY KEY (id_alamat);
 <   ALTER TABLE ONLY public.alamat DROP CONSTRAINT alamat_pkey;
       public            postgres    false    207            �
           2606    17149    barang barang_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.barang
    ADD CONSTRAINT barang_pkey PRIMARY KEY (id_barang);
 <   ALTER TABLE ONLY public.barang DROP CONSTRAINT barang_pkey;
       public            postgres    false    215            �
           2606    17084    kota kota_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.kota
    ADD CONSTRAINT kota_pkey PRIMARY KEY (id_kota);
 8   ALTER TABLE ONLY public.kota DROP CONSTRAINT kota_pkey;
       public            postgres    false    205            �
           2606    17123    layanan layanan_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.layanan
    ADD CONSTRAINT layanan_pkey PRIMARY KEY (id_layanan);
 >   ALTER TABLE ONLY public.layanan DROP CONSTRAINT layanan_pkey;
       public            postgres    false    211            �
           2606    29392    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            postgres    false    217            �
           2606    17131    paket paket_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_pkey PRIMARY KEY (id_paket);
 :   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_pkey;
       public            postgres    false    213            �
           2606    17110    pelanggan pelanggan_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.pelanggan
    ADD CONSTRAINT pelanggan_pkey PRIMARY KEY (id_pelanggan);
 B   ALTER TABLE ONLY public.pelanggan DROP CONSTRAINT pelanggan_pkey;
       public            postgres    false    209            �
           2606    17076    provinsi provinsi_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.provinsi
    ADD CONSTRAINT provinsi_pkey PRIMARY KEY (id_provinsi);
 @   ALTER TABLE ONLY public.provinsi DROP CONSTRAINT provinsi_pkey;
       public            postgres    false    203            �
           2620    17186    barang tambah_ongkir    TRIGGER     q   CREATE TRIGGER tambah_ongkir AFTER INSERT ON public.barang FOR EACH ROW EXECUTE FUNCTION public.hitung_ongkir();
 -   DROP TRIGGER tambah_ongkir ON public.barang;
       public          postgres    false    218    215            �
           2606    17098    alamat alamat_id_kota_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.alamat
    ADD CONSTRAINT alamat_id_kota_fkey FOREIGN KEY (id_kota) REFERENCES public.kota(id_kota) ON UPDATE CASCADE ON DELETE RESTRICT;
 D   ALTER TABLE ONLY public.alamat DROP CONSTRAINT alamat_id_kota_fkey;
       public          postgres    false    205    207    2741            �
           2606    17155    barang barang_id_paket_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.barang
    ADD CONSTRAINT barang_id_paket_fkey FOREIGN KEY (id_paket) REFERENCES public.paket(id_paket) ON UPDATE CASCADE ON DELETE RESTRICT;
 E   ALTER TABLE ONLY public.barang DROP CONSTRAINT barang_id_paket_fkey;
       public          postgres    false    2749    215    213            �
           2606    17085    kota kota_id_provinsi_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.kota
    ADD CONSTRAINT kota_id_provinsi_fkey FOREIGN KEY (id_provinsi) REFERENCES public.provinsi(id_provinsi) ON UPDATE CASCADE ON DELETE RESTRICT;
 D   ALTER TABLE ONLY public.kota DROP CONSTRAINT kota_id_provinsi_fkey;
       public          postgres    false    205    2739    203            �
           2606    17137 !   paket paket_id_alamat_tujuan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_id_alamat_tujuan_fkey FOREIGN KEY (id_alamat_tujuan) REFERENCES public.alamat(id_alamat) ON UPDATE CASCADE ON DELETE RESTRICT;
 K   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_id_alamat_tujuan_fkey;
       public          postgres    false    213    207    2743            �
           2606    17132    paket paket_id_layanan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_id_layanan_fkey FOREIGN KEY (id_layanan) REFERENCES public.layanan(id_layanan) ON UPDATE CASCADE ON DELETE RESTRICT;
 E   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_id_layanan_fkey;
       public          postgres    false    211    2747    213            �
           2606    17174    paket paket_id_pelanggan_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.paket
    ADD CONSTRAINT paket_id_pelanggan_fkey FOREIGN KEY (id_pelanggan) REFERENCES public.pelanggan(id_pelanggan) ON UPDATE CASCADE ON DELETE RESTRICT;
 G   ALTER TABLE ONLY public.paket DROP CONSTRAINT paket_id_pelanggan_fkey;
       public          postgres    false    2745    213    209            �
           2606    17111 "   pelanggan pelanggan_id_alamat_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pelanggan
    ADD CONSTRAINT pelanggan_id_alamat_fkey FOREIGN KEY (id_alamat) REFERENCES public.alamat(id_alamat) ON UPDATE CASCADE ON DELETE RESTRICT;
 L   ALTER TABLE ONLY public.pelanggan DROP CONSTRAINT pelanggan_id_alamat_fkey;
       public          postgres    false    2743    207    209            M   W  x����N�0E���{�^���@��ͨDQ�4�Ҵ��I!�Mَ�=��1`"�Z���ԓD ̳�q��<Zc����)
�<|��N�y��6)@,T 
�톺��PqFa�"��R�4���ס����Qh��N���I2�d�;kP������5��J�Vꂙ�K7Lg�Z�����e۶�Ԓ�R���E��a�=u���ac*�`���$�`q�ʁ�&�#
���y�|T��bG�I�Y�Y9��Q���;�f��r�V��X�h+l�>�����pn��2���'0�q��s��=e
��F�E�;�������Anb���}B|\7��      U   "  x�m��n�0����'���9����C�^�ĀIbGvRѷU��b����Y�T��=��|�9��;�"�GrƊ��gmj�d<�������5��ն%d<Ŕ0:Kg+�g��X����rw��7L"4�<��d����uηt�!`6BdW�bT��}0�a�ɥ�7�<�3��d��Ϧ�"������5yt|r�^���������2,�N�г��Í��ɠp�����!9*FظN�{��G�����Ԝ��3�p*T,T
�g�7�;^x�B|�0x&      K   	  x�m�Kn�0@יS��%���m��¨t��("Z�����P��M�(����]v��&�q2�o8;�q�<���NA�z;���Cwr�9:�@&��u���d�ћ��@1�d��x�8tCC� ��޴�[�v�����Gr�2�À��H�%�����	=�).R$������d�?9ȸ�O��)t���Ӿ��_��E���tx���%�K�!r�yp#��� �����C\����r.[�֡?��2�ShbM!�u�hΐs�o�؛r���(��*������݄ԋS �m�K�|� �
>�*�O0�N�le�ʶ�
���ĉj�u���A軜��	=�z�b�Ʈԅ(��OqgE�i���Cwu=���soCKF�m���x��d���A�|��qp���'s�]��X�+UArͽib#��<�؃��>����ІH�gr.���,Hnx���s@�$2,� ��!��2#H��ޝ74	%7�e�s��5}�Ϝ�֞F(�k:�6�Y�}_��z(eZ��#.ϝ�����~��B9/���R��&cj�R5Yʈ�6�ʩ|C4��^+[6��;���c���0�z�@�<�?JqJ'�U1xoq�P:�tӕ�K0����~D&�r�����*�q
�	݇�Ω���3]A���-T\�0OSSw����ߊ�an�J'���z�����5ʕ_(�]
:��,��K���!t��.6��F��U���|o|��'X����<���@��y�|�ۭ�v���_���      Q   7   x�3�JM/�I-�4500�2�t�((J-.�4�9��S�RSS�
�b���� �.      W      x������ � �      S   �   x�}����@�s�+��Ir4 �I/��qH4�=�כE!�GUu��@���!$T�Tc�+�Q��X�nț����Z��C�Up��DJXuËT�ZQ'XFX�i��WL2U���f~�|;��S�C:M��i5~�5���i����SE<���
�9b�v��7~���k��LF�1å��"˲;f�Y>      O   k   x��1
�@���a��$Zg	�@Hc�uBv����_�ztxe�rU���1g��g�[Lc�v�`J��c��o=���g{���9���J��v�'h.���� �      I   +   x�3��J,OT��--�2�rR��3��!<�Ģ��=... 33�     