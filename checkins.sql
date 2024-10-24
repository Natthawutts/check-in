PGDMP                   	    |            studentcheck    16.4    16.4 '               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16608    studentcheck    DATABASE     ~   CREATE DATABASE studentcheck WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Thai_Thailand.874';
    DROP DATABASE studentcheck;
                postgres    false            �            1259    16667 
   attendance    TABLE     �   CREATE TABLE public.attendance (
    id integer NOT NULL,
    student_id bigint NOT NULL,
    check_in_date date NOT NULL,
    attendance_status character varying(20)
);
    DROP TABLE public.attendance;
       public         heap    postgres    false            �            1259    16665    attendance_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.attendance_id_seq;
       public          postgres    false    223                       0    0    attendance_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.attendance_id_seq OWNED BY public.attendance.id;
          public          postgres    false    221            �            1259    16666    attendance_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attendance_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.attendance_student_id_seq;
       public          postgres    false    223                       0    0    attendance_student_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.attendance_student_id_seq OWNED BY public.attendance.student_id;
          public          postgres    false    222            �            1259    16614 
   curriculum    TABLE     �   CREATE TABLE public.curriculum (
    id integer NOT NULL,
    curr_name_th character varying(100),
    curr_name_en character varying(100),
    short_name_th character varying(100),
    short_name_en character varying(100)
);
    DROP TABLE public.curriculum;
       public         heap    postgres    false            �            1259    16609    prefix    TABLE     [   CREATE TABLE public.prefix (
    id integer NOT NULL,
    prefix character varying(100)
);
    DROP TABLE public.prefix;
       public         heap    postgres    false            �            1259    16619    section    TABLE     \   CREATE TABLE public.section (
    id integer NOT NULL,
    section character varying(10)
);
    DROP TABLE public.section;
       public         heap    postgres    false            �            1259    16625    student    TABLE     �  CREATE TABLE public.student (
    id bigint NOT NULL,
    prefix_id integer,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth date,
    sex character varying(20),
    curriculum_id integer,
    previous_school character varying(100),
    address character varying(100),
    telephone character varying(10),
    email character varying(100),
    line_id character varying(20),
    status character varying(10)
);
    DROP TABLE public.student;
       public         heap    postgres    false            �            1259    16624    student_id_seq    SEQUENCE     w   CREATE SEQUENCE public.student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.student_id_seq;
       public          postgres    false    219                       0    0    student_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;
          public          postgres    false    218            �            1259    16643    student_list    TABLE     �   CREATE TABLE public.student_list (
    id integer NOT NULL,
    section_id integer,
    student_id integer,
    active_date date,
    status character varying(10)
);
     DROP TABLE public.student_list;
       public         heap    postgres    false            g           2604    16670    attendance id    DEFAULT     n   ALTER TABLE ONLY public.attendance ALTER COLUMN id SET DEFAULT nextval('public.attendance_id_seq'::regclass);
 <   ALTER TABLE public.attendance ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    221    223            h           2604    16671    attendance student_id    DEFAULT     ~   ALTER TABLE ONLY public.attendance ALTER COLUMN student_id SET DEFAULT nextval('public.attendance_student_id_seq'::regclass);
 D   ALTER TABLE public.attendance ALTER COLUMN student_id DROP DEFAULT;
       public          postgres    false    222    223    223            f           2604    16628 
   student id    DEFAULT     h   ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);
 9   ALTER TABLE public.student ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219                      0    16667 
   attendance 
   TABLE DATA           V   COPY public.attendance (id, student_id, check_in_date, attendance_status) FROM stdin;
    public          postgres    false    223   K-       
          0    16614 
   curriculum 
   TABLE DATA           b   COPY public.curriculum (id, curr_name_th, curr_name_en, short_name_th, short_name_en) FROM stdin;
    public          postgres    false    216   �-       	          0    16609    prefix 
   TABLE DATA           ,   COPY public.prefix (id, prefix) FROM stdin;
    public          postgres    false    215   �.                 0    16619    section 
   TABLE DATA           .   COPY public.section (id, section) FROM stdin;
    public          postgres    false    217   �.                 0    16625    student 
   TABLE DATA           �   COPY public.student (id, prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id, status) FROM stdin;
    public          postgres    false    219   �.                 0    16643    student_list 
   TABLE DATA           W   COPY public.student_list (id, section_id, student_id, active_date, status) FROM stdin;
    public          postgres    false    220   �;                  0    0    attendance_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.attendance_id_seq', 14, true);
          public          postgres    false    221                       0    0    attendance_student_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.attendance_student_id_seq', 1, false);
          public          postgres    false    222                       0    0    student_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.student_id_seq', 1, false);
          public          postgres    false    218            t           2606    16673    attendance attendance_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_pkey;
       public            postgres    false    223            l           2606    16618    curriculum curriculum_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculum_pkey;
       public            postgres    false    216            j           2606    16613    prefix prefix_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.prefix
    ADD CONSTRAINT prefix_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.prefix DROP CONSTRAINT prefix_pkey;
       public            postgres    false    215            n           2606    16623    section section_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.section DROP CONSTRAINT section_pkey;
       public            postgres    false    217            r           2606    16647    student_list student_list_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_pkey;
       public            postgres    false    220            p           2606    16632    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    219            y           2606    16674 %   attendance attendance_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 O   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_student_id_fkey;
       public          postgres    false    223    4720    219            u           2606    16638 "   student student_curriculum_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_curriculum_id_fkey FOREIGN KEY (curriculum_id) REFERENCES public.curriculum(id);
 L   ALTER TABLE ONLY public.student DROP CONSTRAINT student_curriculum_id_fkey;
       public          postgres    false    216    219    4716            w           2606    16648 )   student_list student_list_section_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.section(id);
 S   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_section_id_fkey;
       public          postgres    false    220    4718    217            x           2606    16653 )   student_list student_list_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 S   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_student_id_fkey;
       public          postgres    false    220    4720    219            v           2606    16633    student student_prefix_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_prefix_id_fkey FOREIGN KEY (prefix_id) REFERENCES public.prefix(id);
 H   ALTER TABLE ONLY public.student DROP CONSTRAINT student_prefix_id_fkey;
       public          postgres    false    219    4714    215               T   x��˱�0�:�%��$��aX�� 	�l�PҀP�?xj�:��,�ђbU�fŮ8�b1�7�7���
�	���`f7f�      
   �   x��P�
�@�s_qe������F�Sz'A;K-����o�SLVR�h�↽�ٙ��9�=�
Z�����x�A�	h:�f�)3��	i��2?d�@c�	����G<`��C�)�TS�l(m]�U���20�h۝^W���c�D~�����s
~Y�'���Bj�HW���q�Z��q�̘���%S�a������ƶl���{�,�gOT}!�]�>�      	      x�3�|�c���X�eg�s��qqq ��            x������ � �         �  x��Z�r�����B/�� ���U����`d5bmQ���;�Ք�5NDE�4��d4����9����s�,�D��F�g�=?�9�U?({n��+u�u��:����$�$�q���L:M�O bwI�C�I<K�?�'�[���Ӳ���?9�C����x`C���70����x����kw��c/��K�F���5���z�ė���uw����7��(<�~�ۀ�'0*�T�H⟝r�MU	�����h�v����h��b������E����'�
�V��vN��a��a�<��{�*����ׁ��?;L�����t?��-��R�����Pܶa����C��x����Ӗ/d �[����A�	��bka"��-�nA�;a'̞	�#��\$F|9u
�'��~Z�#>.Ӿ��\�>|g��%��@�����ո����vc�g��g/l���q��~� f�m��Uj�ً�ы�-ݨPf���j`V���(q�}D<�z���I�Zy�}M�/�g�W����{n�b�����0
�-����S湡���>��봢���n�k��0+>��� ֐����B���Jj��栖��>4��&~�T�J)0�tB���p��¤�� Ę��<�Z���mv�W��Hh��+౨�!Y��)1s��?��W��i�����cx��z�C'��JUi�`$K�k5�){	�����v���Q�p5)�	ܐb8�a?<����ށ�c�F���p�`�!���Rmm_���2��<4��n�����#�_(�R�&��<iЩ?(心0pxK0:��/�U@��SP�9�`��j�ݸ����<L$�ӎ:���)����ȍ�J";���@q�\�-8a���"�E �-3��m6H�pO�hd*D2�Ԕ�����Dͨ��Hl\j�rJ����y���	e�"���@H����y%f����v��%����#��ͻ� �h���8�I�9(�5���hG�^�@��Ʋ�{�%�'P{�{(��-(��yL��
첀��|Ύ ���2֏�i����\�z_P�F�{j\��D���6J�����t������"�����z�Չ��aU#�M}N����\����U���P�Sh@�R��\��g�b���a�\�oܜ��.dp�]rW�g0����<Zu	YӹA\2�܀�P��^:��a�u���?U��8zנ�F�@�<''a��[�ԟR�>�=���ѫ5�)��Ol$�g�ٌ�3va���f�Bڻ0��Ho �����l�r�.̉���aD���Y#�s���<�1,��=]��
L�lT�rMA�d�]XO3�m\���pԦ��b����􂼠�D�A�>���P�u���Yf ���Fd�*5E���8m5`�?��+�)� �P}�'ȫ����W��r>�H��{-4NU%qg��D쿑y<�P� �0�H�b���/@��8�En%��9E��+��F�eTbX,�n���͙P�����V;jY�#� 1B�U�]
c�`����gY�
):E�ӼcŎ�G�xF�^�u���P�>��v̄��H^/(�ރ�����}�=�A�Ma@�ɨj�W�{\��Oi�#Z�� �h6���Ò����ku"�X���
��oؚ���,�M~J�)��j����)r�=#'ܒ�qw�f�Gva�y�M��d�È�klVI6��h��[H2�	|�g��D��s��j4���R�^׺I��<�Я��ScC��)�x	����6 G[��*+�Z�\V�C�+�Eռ���QǤ�rW��V��V�	Mz�
Xu�9��
`e��m�#�6<��9�guިf�]a�H��_����\�0Gi�������ږT̚��n5N��7�N'j���3�f������ �ē����Ҙ����R�f�2�TcFg%��𦱧rt��>��ө��]֜�#pe�w9��@Z�=x��6K�;F�L�g Ʋ��EZG���Y�F��h%V�8�bm/����"g�R������s�1XY'�8�j���S�_`��h��Нl�q��Ln/�����R�p?T�<��·��?@��jI�Ρ�L�јZ!^���y��nt"U!ˀ�&��X��B�C�a�X聒>���Й�-&v���M�p��W�sF�EAz�b�p<È�DR)'��kV[e�/��F�+{TRL�c1��ao�m�&��d�e��8���l���������c;�i�a��eV�.�G�-(�O�b HΉ�/$b�|�ԕ����i��u�Z�Kk����͗�M�Z�7����U:j[PP�#b��K:�ĉ�D��fV�hC�k�Z�[�F�ǋ*�06���J�D�Z��8*�c[Q��~�`��2�
\*P��dqD=|ҧs�3`Z=��� �����#߬.�9���Ϡ�i#���et~H��M=�ɓ���~T�$-?���h��˟զ�dJa{���n���W�ZsB�M�1Y�꭮�sX���5�J�s)�ZCʶ�P-�~^�6�_E�hs;��	3��`g�t�t�I6~�u�?�>�.��m'���"4H-�A�e��:�=tKtnb�);�]�n�����v��n4_D�uk��,����$��RN��\�	1������7��C�J8-�6ϲ�MKH�¶s[���r�h�L��c�J<�m="/���"ʣ�c���j�I�k�	�=^��Ս����w�����$������ �!���N�W�+E	�Wd�#�	*��,��?�A�Q�Z�M~���B�J�%]2,��k�</����7e$��6�?��54�|��~�kic�y��i��KB��B簢c2��z�s����!x��$i�ɽ�b��f�G�ة7�;��S�e����h� ׎�G�ct��|%q(��_�O�[���ː�W��nxZ��T���m�уڗ�-~C홁�f ���1�oD��D)[���5�Ճ,�gʡ�>�m�)l�O�Hƴ]c�k�a��3i���H�׻�Z�F�W�2��F��.����H��dOp0(ls�^���=� 0�F]y�׮�Z��.�X\kX�iTY�����bE݊*N^��l���_[�YJ3��W՛��i�C����-o�f�";���9Hbjk.��ZA�}K�yo�����F� �H16�9��X� I(A��WO�<���Zc            x������ � �     