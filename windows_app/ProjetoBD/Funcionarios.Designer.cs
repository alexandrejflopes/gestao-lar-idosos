namespace ProjetoBD
{
    partial class Funcionarios
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Funcionarios));
            this.buttonAddFuncionario = new System.Windows.Forms.Button();
            this.botaoSair = new System.Windows.Forms.Button();
            this.listBoxFuncionarios = new System.Windows.Forms.ListBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.comboBoxSexo = new System.Windows.Forms.ComboBox();
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.labelNovoFunc = new System.Windows.Forms.Label();
            this.botaoCancelarAdd = new System.Windows.Forms.Button();
            this.botaoGuardarAdd = new System.Windows.Forms.Button();
            this.botaoCancelar = new System.Windows.Forms.Button();
            this.botaoGuardar = new System.Windows.Forms.Button();
            this.textID = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.textPhone = new System.Windows.Forms.TextBox();
            this.funcionarioFoto = new System.Windows.Forms.PictureBox();
            this.labelNoFuncionario = new System.Windows.Forms.Label();
            this.botaoEditFuncionario = new System.Windows.Forms.Button();
            this.Label9 = new System.Windows.Forms.Label();
            this.Label5 = new System.Windows.Forms.Label();
            this.Label2 = new System.Windows.Forms.Label();
            this.Label1 = new System.Windows.Forms.Label();
            this.textSexo = new System.Windows.Forms.TextBox();
            this.textNasc = new System.Windows.Forms.TextBox();
            this.textNIF = new System.Windows.Forms.TextBox();
            this.textNome = new System.Windows.Forms.TextBox();
            this.botaoEliminarFuncionario = new System.Windows.Forms.Button();
            this.textTotalFuncionarios = new System.Windows.Forms.Label();
            this.labelTotalFuncionarios = new System.Windows.Forms.Label();
            this.buttonAddCuidado = new System.Windows.Forms.Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.funcionarioFoto)).BeginInit();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonAddFuncionario
            // 
            this.buttonAddFuncionario.BackColor = System.Drawing.Color.MediumTurquoise;
            this.buttonAddFuncionario.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.buttonAddFuncionario.ForeColor = System.Drawing.Color.White;
            this.buttonAddFuncionario.Location = new System.Drawing.Point(150, 21);
            this.buttonAddFuncionario.Name = "buttonAddFuncionario";
            this.buttonAddFuncionario.Size = new System.Drawing.Size(170, 51);
            this.buttonAddFuncionario.TabIndex = 172;
            this.buttonAddFuncionario.Text = "Novo funcionário";
            this.buttonAddFuncionario.UseVisualStyleBackColor = false;
            this.buttonAddFuncionario.Click += new System.EventHandler(this.ButtonAddFuncionario_Click);
            // 
            // botaoSair
            // 
            this.botaoSair.BackColor = System.Drawing.Color.Coral;
            this.botaoSair.FlatAppearance.BorderColor = System.Drawing.Color.Snow;
            this.botaoSair.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoSair.ForeColor = System.Drawing.Color.White;
            this.botaoSair.Location = new System.Drawing.Point(12, 21);
            this.botaoSair.Name = "botaoSair";
            this.botaoSair.Size = new System.Drawing.Size(132, 51);
            this.botaoSair.TabIndex = 171;
            this.botaoSair.Text = "Início";
            this.botaoSair.UseVisualStyleBackColor = false;
            this.botaoSair.Click += new System.EventHandler(this.BotaoSair_Click);
            // 
            // listBoxFuncionarios
            // 
            this.listBoxFuncionarios.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.listBoxFuncionarios.FormattingEnabled = true;
            this.listBoxFuncionarios.ItemHeight = 23;
            this.listBoxFuncionarios.Location = new System.Drawing.Point(12, 87);
            this.listBoxFuncionarios.Name = "listBoxFuncionarios";
            this.listBoxFuncionarios.Size = new System.Drawing.Size(473, 395);
            this.listBoxFuncionarios.TabIndex = 170;
            this.listBoxFuncionarios.SelectedIndexChanged += new System.EventHandler(this.ListBoxFuncionarios_SelectedIndexChanged);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.comboBoxSexo);
            this.panel1.Controls.Add(this.dateTimePicker1);
            this.panel1.Controls.Add(this.labelNovoFunc);
            this.panel1.Controls.Add(this.botaoCancelarAdd);
            this.panel1.Controls.Add(this.botaoGuardarAdd);
            this.panel1.Controls.Add(this.botaoCancelar);
            this.panel1.Controls.Add(this.botaoGuardar);
            this.panel1.Controls.Add(this.textID);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.textPhone);
            this.panel1.Controls.Add(this.funcionarioFoto);
            this.panel1.Controls.Add(this.labelNoFuncionario);
            this.panel1.Controls.Add(this.botaoEditFuncionario);
            this.panel1.Controls.Add(this.Label9);
            this.panel1.Controls.Add(this.Label5);
            this.panel1.Controls.Add(this.Label2);
            this.panel1.Controls.Add(this.Label1);
            this.panel1.Controls.Add(this.textSexo);
            this.panel1.Controls.Add(this.textNasc);
            this.panel1.Controls.Add(this.textNIF);
            this.panel1.Controls.Add(this.textNome);
            this.panel1.Controls.Add(this.botaoEliminarFuncionario);
            this.panel1.Location = new System.Drawing.Point(491, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(539, 532);
            this.panel1.TabIndex = 169;
            // 
            // comboBoxSexo
            // 
            this.comboBoxSexo.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.comboBoxSexo.FormattingEnabled = true;
            this.comboBoxSexo.Items.AddRange(new object[] {
            "M",
            "F"});
            this.comboBoxSexo.Location = new System.Drawing.Point(282, 372);
            this.comboBoxSexo.Name = "comboBoxSexo";
            this.comboBoxSexo.Size = new System.Drawing.Size(94, 31);
            this.comboBoxSexo.TabIndex = 174;
            // 
            // dateTimePicker1
            // 
            this.dateTimePicker1.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.dateTimePicker1.Location = new System.Drawing.Point(33, 266);
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.Size = new System.Drawing.Size(242, 30);
            this.dateTimePicker1.TabIndex = 178;
            // 
            // labelNovoFunc
            // 
            this.labelNovoFunc.AutoSize = true;
            this.labelNovoFunc.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNovoFunc.ForeColor = System.Drawing.Color.DimGray;
            this.labelNovoFunc.Location = new System.Drawing.Point(193, 40);
            this.labelNovoFunc.Name = "labelNovoFunc";
            this.labelNovoFunc.Size = new System.Drawing.Size(292, 46);
            this.labelNovoFunc.TabIndex = 177;
            this.labelNovoFunc.Text = "Novo Funcionário";
            // 
            // botaoCancelarAdd
            // 
            this.botaoCancelarAdd.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.botaoCancelarAdd.BackColor = System.Drawing.Color.Coral;
            this.botaoCancelarAdd.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoCancelarAdd.ForeColor = System.Drawing.Color.White;
            this.botaoCancelarAdd.Location = new System.Drawing.Point(292, 463);
            this.botaoCancelarAdd.Margin = new System.Windows.Forms.Padding(4);
            this.botaoCancelarAdd.Name = "botaoCancelarAdd";
            this.botaoCancelarAdd.Size = new System.Drawing.Size(155, 52);
            this.botaoCancelarAdd.TabIndex = 176;
            this.botaoCancelarAdd.Text = "Cancelar";
            this.botaoCancelarAdd.UseVisualStyleBackColor = false;
            this.botaoCancelarAdd.Click += new System.EventHandler(this.BotaoCancelarAdd_Click);
            // 
            // botaoGuardarAdd
            // 
            this.botaoGuardarAdd.BackColor = System.Drawing.Color.MediumTurquoise;
            this.botaoGuardarAdd.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoGuardarAdd.ForeColor = System.Drawing.Color.White;
            this.botaoGuardarAdd.Location = new System.Drawing.Point(86, 463);
            this.botaoGuardarAdd.Name = "botaoGuardarAdd";
            this.botaoGuardarAdd.Size = new System.Drawing.Size(155, 52);
            this.botaoGuardarAdd.TabIndex = 175;
            this.botaoGuardarAdd.Text = "Registar";
            this.botaoGuardarAdd.UseVisualStyleBackColor = false;
            this.botaoGuardarAdd.Click += new System.EventHandler(this.BotaoGuardarAdd_Click);
            // 
            // botaoCancelar
            // 
            this.botaoCancelar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.botaoCancelar.BackColor = System.Drawing.Color.Coral;
            this.botaoCancelar.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoCancelar.ForeColor = System.Drawing.Color.White;
            this.botaoCancelar.Location = new System.Drawing.Point(292, 463);
            this.botaoCancelar.Margin = new System.Windows.Forms.Padding(4);
            this.botaoCancelar.Name = "botaoCancelar";
            this.botaoCancelar.Size = new System.Drawing.Size(155, 52);
            this.botaoCancelar.TabIndex = 174;
            this.botaoCancelar.Text = "Cancelar";
            this.botaoCancelar.UseVisualStyleBackColor = false;
            this.botaoCancelar.Click += new System.EventHandler(this.BotaoCancelar_Click);
            // 
            // botaoGuardar
            // 
            this.botaoGuardar.BackColor = System.Drawing.Color.MediumTurquoise;
            this.botaoGuardar.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoGuardar.ForeColor = System.Drawing.Color.White;
            this.botaoGuardar.Location = new System.Drawing.Point(86, 463);
            this.botaoGuardar.Name = "botaoGuardar";
            this.botaoGuardar.Size = new System.Drawing.Size(155, 52);
            this.botaoGuardar.TabIndex = 173;
            this.botaoGuardar.Text = "Guardar";
            this.botaoGuardar.UseVisualStyleBackColor = false;
            this.botaoGuardar.Click += new System.EventHandler(this.BotaoGuardar_Click);
            // 
            // textID
            // 
            this.textID.AutoSize = true;
            this.textID.BackColor = System.Drawing.Color.Transparent;
            this.textID.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textID.ForeColor = System.Drawing.Color.DimGray;
            this.textID.Location = new System.Drawing.Point(443, 40);
            this.textID.Name = "textID";
            this.textID.Size = new System.Drawing.Size(77, 46);
            this.textID.TabIndex = 172;
            this.textID.Text = "000";
            // 
            // label3
            // 
            this.label3.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label3.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.label3.Location = new System.Drawing.Point(29, 339);
            this.label3.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(209, 20);
            this.label3.TabIndex = 170;
            this.label3.Text = "Número de telefone";
            // 
            // textPhone
            // 
            this.textPhone.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textPhone.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textPhone.Location = new System.Drawing.Point(33, 372);
            this.textPhone.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.textPhone.Name = "textPhone";
            this.textPhone.ReadOnly = true;
            this.textPhone.Size = new System.Drawing.Size(193, 30);
            this.textPhone.TabIndex = 171;
            // 
            // funcionarioFoto
            // 
            this.funcionarioFoto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.funcionarioFoto.Location = new System.Drawing.Point(33, 46);
            this.funcionarioFoto.Margin = new System.Windows.Forms.Padding(10);
            this.funcionarioFoto.Name = "funcionarioFoto";
            this.funcionarioFoto.Size = new System.Drawing.Size(144, 144);
            this.funcionarioFoto.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.funcionarioFoto.TabIndex = 169;
            this.funcionarioFoto.TabStop = false;
            // 
            // labelNoFuncionario
            // 
            this.labelNoFuncionario.AutoSize = true;
            this.labelNoFuncionario.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNoFuncionario.ForeColor = System.Drawing.Color.DimGray;
            this.labelNoFuncionario.Location = new System.Drawing.Point(193, 40);
            this.labelNoFuncionario.Name = "labelNoFuncionario";
            this.labelNoFuncionario.Size = new System.Drawing.Size(241, 46);
            this.labelNoFuncionario.TabIndex = 168;
            this.labelNoFuncionario.Text = "Empregado nº";
            this.labelNoFuncionario.Click += new System.EventHandler(this.Label19_Click);
            // 
            // botaoEditFuncionario
            // 
            this.botaoEditFuncionario.BackColor = System.Drawing.Color.MediumTurquoise;
            this.botaoEditFuncionario.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoEditFuncionario.ForeColor = System.Drawing.Color.White;
            this.botaoEditFuncionario.Location = new System.Drawing.Point(86, 463);
            this.botaoEditFuncionario.Name = "botaoEditFuncionario";
            this.botaoEditFuncionario.Size = new System.Drawing.Size(155, 52);
            this.botaoEditFuncionario.TabIndex = 167;
            this.botaoEditFuncionario.Text = "Editar";
            this.botaoEditFuncionario.UseVisualStyleBackColor = false;
            this.botaoEditFuncionario.Click += new System.EventHandler(this.BotaoEditFuncionario_Click);
            // 
            // Label9
            // 
            this.Label9.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label9.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label9.Location = new System.Drawing.Point(278, 339);
            this.Label9.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.Label9.Name = "Label9";
            this.Label9.Size = new System.Drawing.Size(59, 20);
            this.Label9.TabIndex = 150;
            this.Label9.Text = "Sexo";
            // 
            // Label5
            // 
            this.Label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label5.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label5.Location = new System.Drawing.Point(29, 227);
            this.Label5.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.Label5.Name = "Label5";
            this.Label5.Size = new System.Drawing.Size(209, 20);
            this.Label5.TabIndex = 148;
            this.Label5.Text = "Data de nascimento";
            // 
            // Label2
            // 
            this.Label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label2.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label2.Location = new System.Drawing.Point(310, 227);
            this.Label2.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.Label2.Name = "Label2";
            this.Label2.Size = new System.Drawing.Size(66, 31);
            this.Label2.TabIndex = 144;
            this.Label2.Text = "NIF";
            // 
            // Label1
            // 
            this.Label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label1.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label1.Location = new System.Drawing.Point(197, 123);
            this.Label1.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.Label1.Name = "Label1";
            this.Label1.Size = new System.Drawing.Size(96, 20);
            this.Label1.TabIndex = 142;
            this.Label1.Text = "Nome";
            // 
            // textSexo
            // 
            this.textSexo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textSexo.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textSexo.Location = new System.Drawing.Point(282, 372);
            this.textSexo.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.textSexo.Name = "textSexo";
            this.textSexo.ReadOnly = true;
            this.textSexo.Size = new System.Drawing.Size(52, 30);
            this.textSexo.TabIndex = 151;
            // 
            // textNasc
            // 
            this.textNasc.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textNasc.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textNasc.Location = new System.Drawing.Point(33, 266);
            this.textNasc.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.textNasc.Name = "textNasc";
            this.textNasc.ReadOnly = true;
            this.textNasc.Size = new System.Drawing.Size(193, 30);
            this.textNasc.TabIndex = 149;
            // 
            // textNIF
            // 
            this.textNIF.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textNIF.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textNIF.Location = new System.Drawing.Point(314, 266);
            this.textNIF.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.textNIF.Name = "textNIF";
            this.textNIF.ReadOnly = true;
            this.textNIF.Size = new System.Drawing.Size(193, 30);
            this.textNIF.TabIndex = 145;
            // 
            // textNome
            // 
            this.textNome.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textNome.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textNome.Location = new System.Drawing.Point(201, 160);
            this.textNome.Margin = new System.Windows.Forms.Padding(4);
            this.textNome.Name = "textNome";
            this.textNome.ReadOnly = true;
            this.textNome.Size = new System.Drawing.Size(306, 30);
            this.textNome.TabIndex = 143;
            // 
            // botaoEliminarFuncionario
            // 
            this.botaoEliminarFuncionario.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.botaoEliminarFuncionario.BackColor = System.Drawing.Color.Coral;
            this.botaoEliminarFuncionario.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoEliminarFuncionario.ForeColor = System.Drawing.Color.White;
            this.botaoEliminarFuncionario.Location = new System.Drawing.Point(292, 463);
            this.botaoEliminarFuncionario.Margin = new System.Windows.Forms.Padding(4);
            this.botaoEliminarFuncionario.Name = "botaoEliminarFuncionario";
            this.botaoEliminarFuncionario.Size = new System.Drawing.Size(155, 52);
            this.botaoEliminarFuncionario.TabIndex = 162;
            this.botaoEliminarFuncionario.Text = "Eliminar";
            this.botaoEliminarFuncionario.UseVisualStyleBackColor = false;
            this.botaoEliminarFuncionario.Click += new System.EventHandler(this.BotaoEliminarFuncionario_Click);
            // 
            // textTotalFuncionarios
            // 
            this.textTotalFuncionarios.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textTotalFuncionarios.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textTotalFuncionarios.Location = new System.Drawing.Point(263, 20);
            this.textTotalFuncionarios.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.textTotalFuncionarios.Name = "textTotalFuncionarios";
            this.textTotalFuncionarios.Size = new System.Drawing.Size(45, 32);
            this.textTotalFuncionarios.TabIndex = 167;
            this.textTotalFuncionarios.Text = "2";
            // 
            // labelTotalFuncionarios
            // 
            this.labelTotalFuncionarios.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labelTotalFuncionarios.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.labelTotalFuncionarios.Location = new System.Drawing.Point(13, 20);
            this.labelTotalFuncionarios.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.labelTotalFuncionarios.Name = "labelTotalFuncionarios";
            this.labelTotalFuncionarios.Size = new System.Drawing.Size(242, 32);
            this.labelTotalFuncionarios.TabIndex = 166;
            this.labelTotalFuncionarios.Text = "Número de funcionários: ";
            // 
            // buttonAddCuidado
            // 
            this.buttonAddCuidado.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonAddCuidado.BackColor = System.Drawing.Color.Coral;
            this.buttonAddCuidado.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.buttonAddCuidado.ForeColor = System.Drawing.Color.White;
            this.buttonAddCuidado.Location = new System.Drawing.Point(327, 21);
            this.buttonAddCuidado.Margin = new System.Windows.Forms.Padding(4);
            this.buttonAddCuidado.Name = "buttonAddCuidado";
            this.buttonAddCuidado.Size = new System.Drawing.Size(183, 51);
            this.buttonAddCuidado.TabIndex = 179;
            this.buttonAddCuidado.Text = "Responsabilidades";
            this.buttonAddCuidado.UseVisualStyleBackColor = false;
            this.buttonAddCuidado.Click += new System.EventHandler(this.ButtonAddCuidado_Click);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.labelTotalFuncionarios);
            this.panel2.Controls.Add(this.textTotalFuncionarios);
            this.panel2.Location = new System.Drawing.Point(12, 488);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(473, 56);
            this.panel2.TabIndex = 173;
            // 
            // Funcionarios
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1042, 556);
            this.Controls.Add(this.buttonAddCuidado);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.buttonAddFuncionario);
            this.Controls.Add(this.botaoSair);
            this.Controls.Add(this.listBoxFuncionarios);
            this.Controls.Add(this.panel1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Funcionarios";
            this.Text = "Funcionarios";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Funcionarios_FormClosing);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.funcionarioFoto)).EndInit();
            this.panel2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button buttonAddFuncionario;
        private System.Windows.Forms.Button botaoSair;
        private System.Windows.Forms.ListBox listBoxFuncionarios;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label labelNoFuncionario;
        private System.Windows.Forms.Button botaoEditFuncionario;
        internal System.Windows.Forms.Label Label9;
        internal System.Windows.Forms.Label Label5;
        internal System.Windows.Forms.Label Label2;
        internal System.Windows.Forms.Label Label1;
        internal System.Windows.Forms.TextBox textSexo;
        internal System.Windows.Forms.TextBox textNasc;
        internal System.Windows.Forms.TextBox textNIF;
        internal System.Windows.Forms.TextBox textNome;
        private System.Windows.Forms.Button botaoEliminarFuncionario;
        private System.Windows.Forms.PictureBox funcionarioFoto;
        internal System.Windows.Forms.Label label3;
        internal System.Windows.Forms.TextBox textPhone;
        private System.Windows.Forms.Label textID;
        private System.Windows.Forms.Button botaoGuardar;
        private System.Windows.Forms.Button botaoCancelar;
        private System.Windows.Forms.Button botaoCancelarAdd;
        private System.Windows.Forms.Button botaoGuardarAdd;
        private System.Windows.Forms.Label labelNovoFunc;
        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.ComboBox comboBoxSexo;
        internal System.Windows.Forms.Label textTotalFuncionarios;
        internal System.Windows.Forms.Label labelTotalFuncionarios;
        private System.Windows.Forms.Button buttonAddCuidado;
        private System.Windows.Forms.Panel panel2;
    }
}