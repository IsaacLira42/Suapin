import 'package:flutter/material.dart';
import '../widgets/base_page.dart';
import '../widgets/titulo_da_pagina.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TituloDaPagina(
            titulo: "Caixa de Entrada",
            textoAuxiliar: "COMUNICAÇÃO ACADÊMICA",
            avatarRadius: 18,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 20),
          _buildTabs(),
          const SizedBox(height: 20),
          ..._mockMessages.map(_buildMessageCard).toList(),
          const SizedBox(height: 24),
          _buildWeeklySummary(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F1ED),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: const [
          Expanded(child: _TabChip(label: "Todas", isSelected: true)),
          Expanded(child: _TabChip(label: "Não lidas")),
          Expanded(child: _TabChip(label: "Importantes")),
        ],
      ),
    );
  }

  Widget _buildMessageCard(_InboxMessage message) {
    final bool isHighlighted = message.isUrgent;
    final Color surfaceColor = isHighlighted
        ? Colors.white
        : const Color(0xFFF0F3F1);
    final Color titleColor = isHighlighted
        ? const Color(0xFF1F2937)
        : const Color(0xFF6B7280);
    final Color subtitleColor = isHighlighted
        ? const Color(0xFF0B6B4A)
        : const Color(0xFF7B8A87);
    final Color previewColor = isHighlighted
        ? const Color(0xFF6B7280)
        : const Color(0xFF9AA3A1);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
        border: isHighlighted
            ? const Border(left: BorderSide(color: Color(0xFF0B6B4A), width: 4))
            : null,
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MessageIcon(icon: message.icon, isHighlighted: isHighlighted),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        message.sender,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: titleColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.time,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9AA3A1),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (message.isStarred)
                          Icon(
                            Icons.star,
                            size: 18,
                            color: isHighlighted
                                ? const Color(0xFF0B6B4A)
                                : const Color(0xFFC4CDC8),
                          )
                        else
                          Icon(
                            Icons.mark_email_unread_outlined,
                            size: 18,
                            color: isHighlighted
                                ? const Color(0xFFB4C1BC)
                                : const Color(0xFFD0D6D4),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message.subject,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: subtitleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message.preview,
                  style: TextStyle(fontSize: 13, color: previewColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0B6B4A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Resumo da Semana",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Você tem 12 mensagens pendentes\npara leitura.",
            style: TextStyle(color: Color(0xFFE4F2EB), fontSize: 13),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              _SummaryChip(label: "URGENTES", value: "04"),
              SizedBox(width: 12),
              _SummaryChip(label: "LIDAS", value: "28"),
            ],
          ),
        ],
      ),
    );
  }
}

class _InboxMessage {
  final String sender;
  final String subject;
  final String preview;
  final String time;
  final IconData icon;
  final bool isUrgent;
  final bool isStarred;

  const _InboxMessage({
    required this.sender,
    required this.subject,
    required this.preview,
    required this.time,
    required this.icon,
    this.isUrgent = false,
    this.isStarred = false,
  });
}

const List<_InboxMessage> _mockMessages = [
  _InboxMessage(
    sender: "Prof. Dr. Ricardo Santos",
    subject: "Orientação de\nTCC • Urgente",
    preview: "Prezado aluno,\nanalisei os dados do...",
    time: "10:45\nAM",
    icon: Icons.school,
    isUrgent: true,
    isStarred: true,
  ),
  _InboxMessage(
    sender: "Biblioteca\nCentral",
    subject: "Devolução de\nLivros",
    preview: "Lembramos que o...",
    time: "2 dias\natrás",
    icon: Icons.mail_outline,
  ),
  _InboxMessage(
    sender: "Grupo de\nPequiuka IA",
    subject: "Reunião\nsemanal",
    preview: "Ata da reunião de...",
    time: "3 dias\natrás",
    icon: Icons.group_outlined,
  ),
];

class _TabChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _TabChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0B6B4A) : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF5C6E68),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MessageIcon extends StatelessWidget {
  final IconData icon;
  final bool isHighlighted;

  const _MessageIcon({required this.icon, required this.isHighlighted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFFE6F4EC) : Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFF0B6B4A), size: 20),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F7A55),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFBDE7D4),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
